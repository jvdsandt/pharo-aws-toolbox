Class {
	#name : #AWSSQServiceIntegrationTest,
	#superclass : #AWSSQSIntegrationTest,
	#category : #'AWS-SimpleQueueService-Tests'
}

{ #category : #accessing }
AWSSQServiceIntegrationTest >> sqsTestQueueName [

	^ 'pharo-aws-toolbox-test-q'

	

]

{ #category : #tests }
AWSSQServiceIntegrationTest >> testGetQueueAttributes [

	| testQ response |
	
	testQ := 	self sqsTestQueueUrl.
	response := self sqsservice getQueueAttributes: testQ names: #( 'All' ).
	
	self assert: (response attributeAt: 'MaximumMessageSize') asInteger > (250 * 1024).

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
AWSSQServiceIntegrationTest >> testMessageAttributes [

	| testQ response md5 message |
	
	testQ := self sqsTestQueueUrl.
	
	response := self sqsservice sendMessage: (AWSSQSSendMessageRequest new
			body: 'Message-1';
			addStringAttribute: 'MyString' value: 'MyStringValue';
			addNumberAttribute: 'MyNumber' value: 1234567890;
			addBinaryAttribute: 'MyBytes' value: #[ 100 110 120 130 140 150 160 170 180 190 200 210 220 230 240 250 ];
			yourself)
		on: testQ.
	md5 := (MD5 new hashMessage: 'Message-1' utf8Encoded) hex.
	self assert: response md5OfMessageBody equals: md5.

	(Delay forMilliseconds: 300) wait.
	
	response := self sqsservice receiveMessage: (AWSSQSReceiveMessageRequest new
			maxNumberOfMessages: 1;
			messageAttributeNames: #( 'All' );
			visibilityTimeout: 4;
			yourself)
		on: testQ.
	self assert: response messages size equals: 1.
	message := response messages first.
	self assert: message md5OfBody equals: md5.
	self assert: message body equals: 'Message-1'.
	self assert: (message messageAttributeAt: 'MyString') equals: 'MyStringValue'.
	self assert: (message messageAttributeAt: 'MyNumber') equals: 1234567890.
	self assert: (message messageAttributeAt: 'MyBytes') equals: #[ 100 110 120 130 140 150 160 170 180 190 200 210 220 230 240 250 ].

	response := self sqsservice deleteMessage: message receiptHandle on: testQ.
	self assert: response requestId notNil
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
	self assert: (message attributeAt: 'SenderId') notNil.
	self assert: (message attributeAt: 'SentTimestamp') notNil.

	response := self sqsservice deleteMessage: message receiptHandle on: testQ.
	self assert: response requestId notNil
]
