Class {
	#name : #AWSSQSWriter,
	#superclass : #AWSService,
	#instVars : [
		'sqsservice',
		'queueUrl',
		'delaySeconds'
	],
	#category : #'AWS-SimpleQueueService-Convenience'
}

{ #category : #'instance creation' }
AWSSQSWriter class >> service: aSqsService queueUrl: aQueueUrl [

	^ self new initWithService: aSqsService queueUrl: aQueueUrl
]

{ #category : #accessing }
AWSSQSWriter >> delaySeconds [
	^ delaySeconds
]

{ #category : #accessing }
AWSSQSWriter >> delaySeconds: anObject [
	delaySeconds := anObject
]

{ #category : #initialization }
AWSSQSWriter >> initWithService: aSqsService queueUrl: aQueueUrl [

	sqsservice := aSqsService.
	queueUrl := aQueueUrl
]

{ #category : #resources }
AWSSQSWriter >> newDefaultRequest [

	^ AWSSQSSendMessageRequest new
			delaySeconds: self delaySeconds;
			yourself
]

{ #category : #accessing }
AWSSQSWriter >> queueUrl [
	^ queueUrl
]

{ #category : #accessing }
AWSSQSWriter >> sqsservice [
	^ sqsservice
]

{ #category : #writing }
AWSSQSWriter >> writeBody: aString [

	^ self writeMessage: (self newDefaultRequest 
			body: aString;
			yourself)
]

{ #category : #writing }
AWSSQSWriter >> writeMessage: aSendMessageRequest [

	^ sqsservice sendMessage: aSendMessageRequest on: self queueUrl
]
