Class {
	#name : #AWSSQServiceIntegrationTest,
	#superclass : #AWSIntegrationTest,
	#instVars : [
		'sqsservice'
	],
	#category : #'AWS-SimpleQueueService-Tests'
}

{ #category : #'as yet unclassified' }
AWSSQServiceIntegrationTest >> sqsTestQueueName [

	^ 'pharo-aws-toolbox-test-q'

	

]

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
AWSSQServiceIntegrationTest >> sqsservice [

	^ sqsservice ifNil: [
		sqsservice := AWSSQService newWithCredentials: self class credentials region: self class regionName ]
]

{ #category : #tests }
AWSSQServiceIntegrationTest >> testListQueues [

	| list |
	
	list := self sqsservice listQueues.
	list inspect
	

]

{ #category : #tests }
AWSSQServiceIntegrationTest >> testQueue [

	| testQ |
	
	testQ := self sqsTestQueueUrl.

]
