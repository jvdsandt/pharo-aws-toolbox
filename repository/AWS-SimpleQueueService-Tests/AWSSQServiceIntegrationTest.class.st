Class {
	#name : #AWSSQServiceIntegrationTest,
	#superclass : #AWSIntegrationTest,
	#instVars : [
		'sqsservice'
	],
	#category : #'AWS-SimpleQueueService-Tests'
}

{ #category : #accessing }
AWSSQServiceIntegrationTest >> sqsTestQueueName [

	^ 'pharo-aws-toolbox-test-q'

	

]

{ #category : #accessing }
AWSSQServiceIntegrationTest >> sqsTestQueueUrl [

	| queueUrl |
	
	queueUrl := self sqsservice getQueueUrl: self sqsTestQueueName ifAbsent: [ nil ].
	queueUrl isNil
		ifTrue: [ 
			| result |
			result := self sqsservice createQueue: (AWSSQSCreateQueueRequest new
				queueName: self sqsTestQueueName;
				yourself).
			queueUrl := result queueUrl ].
		
	^ queueUrl
]

{ #category : #accessing }
AWSSQServiceIntegrationTest >> sqsservice [

	^ sqsservice ifNil: [
		sqsservice := AWSSQService newWithCredentials: self class credentials region: self class regionName ]
]

{ #category : #tests }
AWSSQServiceIntegrationTest >> testGetQueueUrl [

	| testQ |
	
	testQ := 	self sqsservice getQueueUrl: 'q-that-does-noet-exist' ifAbsent: [ #notHere ].
	self assert: testQ equals: #notHere.


]

{ #category : #tests }
AWSSQServiceIntegrationTest >> testListQueues [

	| list |
	
	list := self sqsservice listQueues.
	self assert: list notNil
	

]

{ #category : #tests }
AWSSQServiceIntegrationTest >> testMessages [

	| testQ response md5 message |
	
	testQ := self sqsTestQueueUrl.
	
	response := self sqsservice sendMessage: (AWSSQSSendMessageRequest new
			body: 'Message-1';
			yourself)
		on: testQ.
	md5 := (MD5 new hashMessage: 'Message-1' utf8Encoded) hex.
	self assert: response md5OfMessageBody equals: md5.

	(Delay forMilliseconds: 500) wait.
	
	response := self sqsservice receiveMessage: (AWSSQSReceiveMessageRequest new
			maxNumberOfMessages: 1;
			attributeNames: #( 'SenderId' 'SentTimestamp' );
			visibilityTimeout: 4;
			yourself)
		on: testQ.
	self assert: response messages size equals: 1.
	message := response messages first.
	self assert: message md5OfBody equals: md5.
	self assert: message body equals: 'Message-1'.

	response := self sqsservice deleteMessage: message receiptHandle on: testQ.
	self assert: response requestId notNil
]
