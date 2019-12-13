Class {
	#name : #AWSSQSCreateQueueRequest,
	#superclass : #AWSSQSRequest,
	#instVars : [
		'queueName'
	],
	#category : #'AWS-SimpleQueueService'
}

{ #category : #adding }
AWSSQSCreateQueueRequest >> asEntity [

	^ self convertEntity: (
		ZnApplicationFormUrlEncodedEntity new
			at: 'Action' put: 'CreateQueue';
			at: 'QueueName' put: self queueName;
			at: 'Version' put: self version;
			yourself)
]

{ #category : #accessing }
AWSSQSCreateQueueRequest >> queueName [
	^ queueName
]

{ #category : #accessing }
AWSSQSCreateQueueRequest >> queueName: anObject [
	queueName := anObject
]
