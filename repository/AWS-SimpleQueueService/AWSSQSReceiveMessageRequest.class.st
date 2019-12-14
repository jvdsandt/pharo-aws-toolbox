Class {
	#name : #AWSSQSReceiveMessageRequest,
	#superclass : #AWSSQSRequest,
	#instVars : [
		'attributeNames',
		'maxNumberOfMessages',
		'messageAttributeNames',
		'visibilityTimeout',
		'waitTimeSeconds'
	],
	#category : #'AWS-SimpleQueueService'
}

{ #category : #converting }
AWSSQSReceiveMessageRequest >> asEntity [

	| entity |
	
	entity := ZnApplicationFormUrlEncodedEntity new
			at: 'Action' put: 'ReceiveMessage';
			at: 'Version' put: self version;
			yourself.
			
	self waitTimeSeconds 
		ifNotNil: [ entity at: 'WaitTimeSeconds' put: self waitTimeSeconds asString ].
	self maxNumberOfMessages 
		ifNotNil: [ entity at: 'MaxNumberOfMessages' put: self maxNumberOfMessages asString ].
	self visibilityTimeout 
		ifNotNil: [ entity at: 'VisibilityTimeout' put: self visibilityTimeout asString ].
	self attributeNames 
		ifNotNil: [ 
			self attributeNames doWithIndex: [ :name :index |
				entity at: 'AttributeName.', index asString put: name ] ].
	self messageAttributeNames 
		ifNotNil: [ 
			self messageAttributeNames doWithIndex: [ :name :index |
				entity at: 'AttributeName.', index asString put: name ] ].

	^ self class convertEntity: entity
]

{ #category : #accessing }
AWSSQSReceiveMessageRequest >> attributeNames [
	^ attributeNames
]

{ #category : #accessing }
AWSSQSReceiveMessageRequest >> attributeNames: anObject [
	attributeNames := anObject
]

{ #category : #accessing }
AWSSQSReceiveMessageRequest >> maxNumberOfMessages [
	^ maxNumberOfMessages
]

{ #category : #accessing }
AWSSQSReceiveMessageRequest >> maxNumberOfMessages: anObject [
	maxNumberOfMessages := anObject
]

{ #category : #accessing }
AWSSQSReceiveMessageRequest >> messageAttributeNames [
	^ messageAttributeNames
]

{ #category : #accessing }
AWSSQSReceiveMessageRequest >> messageAttributeNames: anObject [
	messageAttributeNames := anObject
]

{ #category : #accessing }
AWSSQSReceiveMessageRequest >> visibilityTimeout [
	^ visibilityTimeout
]

{ #category : #accessing }
AWSSQSReceiveMessageRequest >> visibilityTimeout: anObject [
	visibilityTimeout := anObject
]

{ #category : #accessing }
AWSSQSReceiveMessageRequest >> waitTimeSeconds [
	^ waitTimeSeconds
]

{ #category : #accessing }
AWSSQSReceiveMessageRequest >> waitTimeSeconds: anObject [
	waitTimeSeconds := anObject
]
