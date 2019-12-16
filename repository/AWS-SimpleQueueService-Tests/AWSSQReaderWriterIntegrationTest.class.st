Class {
	#name : #AWSSQReaderWriterIntegrationTest,
	#superclass : #AWSSQSIntegrationTest,
	#category : #'AWS-SimpleQueueService-Tests'
}

{ #category : #accessing }
AWSSQReaderWriterIntegrationTest >> sqsTestQueueName [

	^ 'pharo-aws-toolbox-test-rwq'

	

]

{ #category : #accessing }
AWSSQReaderWriterIntegrationTest >> sqsservice [

	^ AWSSQService newWithCredentials: self credentials region: self regionName
]

{ #category : #tests }
AWSSQReaderWriterIntegrationTest >> testNextMessage [

	| queueUrl writer reader msg1 msg2 |
	
	queueUrl := self sqsTestQueueUrl.
	writer := AWSSQSWriter service: self sqsservice queueUrl: queueUrl.
	reader := AWSSQSReader service: self createSqsservice queueUrl: queueUrl.
	self assert: (reader nextMessageIfNone: [ #none ]) equals: #none.
	
	writer writeBody: 'Message-A'.
	msg1 := reader nextMessage.
	writer writeBody: 'Message-B'.
	msg2 := reader nextMessage.

	self assert: msg1 body equals: 'Message-A'.
	self assert: msg2 body equals: 'Message-B'.
	reader 
		deleteMessage: msg1 receiptHandle;
		deleteMessage: msg2 receiptHandle
]

{ #category : #tests }
AWSSQReaderWriterIntegrationTest >> testProcessBlock [

	| queueUrl writer list semaphore count |
	
	queueUrl := self sqsTestQueueUrl.
	writer := AWSSQSWriter service: self sqsservice queueUrl: queueUrl.
	list := OrderedCollection new.
	semaphore := Semaphore new.
	count := 20.
	[ 
		| reader |
		reader := AWSSQSReader service: self createSqsservice queueUrl: queueUrl.
		[ reader processNextWith: [ :msg | list add: msg ]. list size < count ] whileTrue.
		semaphore signal ] fork.

	1 to: count do: [ :index | 
		(Delay forMilliseconds: 10) wait.
		writer writeBody: 'Message-#', index asString ].
	
	semaphore wait.
	self assert: list size equals: count.
]

{ #category : #tests }
AWSSQReaderWriterIntegrationTest >> testProcessNext [

	| queueUrl writer reader msg1 msg2 |
	
	queueUrl := self sqsTestQueueUrl.
	writer := AWSSQSWriter service: self sqsservice queueUrl: queueUrl.
	reader := AWSSQSReader service: self createSqsservice queueUrl: queueUrl.
	self assert: (reader nextMessageIfNone: [ #none ]) equals: #none.
	
	writer writeBody: 'Message-A'.
	msg1 := reader processNext.
	writer writeBody: 'Message-B'.
	msg2 := reader processNext.

	self assert: msg1 body equals: 'Message-A'.
	self assert: msg2 body equals: 'Message-B'.
]
