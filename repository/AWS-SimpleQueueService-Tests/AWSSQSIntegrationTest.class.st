Class {
	#name : #AWSSQSIntegrationTest,
	#superclass : #AWSIntegrationTest,
	#instVars : [
		'sqsservice'
	],
	#category : #'AWS-SimpleQueueService-Tests'
}

{ #category : #accessing }
AWSSQSIntegrationTest >> clearQueue: queueUrl [

	| response |
	
	response := self sqsservice receiveMessage: (AWSSQSReceiveMessageRequest new
			waitTimeSeconds: 1;
			maxNumberOfMessages: 10;
			yourself)
		on: queueUrl.
	response messages do: [ :each | 
		self sqsservice deleteMessage: each receiptHandle on: queueUrl ]
]

{ #category : #accessing }
AWSSQSIntegrationTest >> createSqsservice [

	^ AWSSQService newWithCredentials: self credentials region: self regionName
]

{ #category : #accessing }
AWSSQSIntegrationTest >> sqsTestQueueName [

	self subclassResponsibility
]

{ #category : #accessing }
AWSSQSIntegrationTest >> sqsTestQueueUrl [

	| queueUrl |
	
	queueUrl := self sqsservice getQueueUrl: self sqsTestQueueName ifAbsent: [ nil ].
	queueUrl isNil
		ifTrue: [ 
			| result |
			result := self sqsservice createQueue: (AWSSQSCreateQueueRequest new
				queueName: self sqsTestQueueName;
				yourself).
			queueUrl := result queueUrl ]
		ifFalse: [ 
			self clearQueue: queueUrl ].
		
	^ queueUrl
]

{ #category : #accessing }
AWSSQSIntegrationTest >> sqsservice [

	^ sqsservice ifNil: [ sqsservice := self createSqsservice ]
]
