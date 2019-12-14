Class {
	#name : #AWSSQSSendMessageRequest,
	#superclass : #AWSSQSRequest,
	#instVars : [
		'body',
		'delaySeconds',
		'attributes'
	],
	#category : #'AWS-SimpleQueueService'
}

{ #category : #converting }
AWSSQSSendMessageRequest >> asEntity [

	| entity |
	
	entity := ZnApplicationFormUrlEncodedEntity new
			at: 'Action' put: 'SendMessage';
			at: 'MessageBody' put: self body;
			at: 'Version' put: self version;
			yourself.
			
	self delaySeconds notNil
		ifTrue: [ entity at: 'DelaySeconds' put: self delaySeconds asString ].

	^ self class convertEntity: entity
]

{ #category : #accessing }
AWSSQSSendMessageRequest >> attributes [
	^ attributes
]

{ #category : #accessing }
AWSSQSSendMessageRequest >> attributes: anObject [
	attributes := anObject
]

{ #category : #accessing }
AWSSQSSendMessageRequest >> body [
	^ body
]

{ #category : #accessing }
AWSSQSSendMessageRequest >> body: anObject [
	body := anObject
]

{ #category : #accessing }
AWSSQSSendMessageRequest >> delaySeconds [
	^ delaySeconds
]

{ #category : #accessing }
AWSSQSSendMessageRequest >> delaySeconds: anObject [
	delaySeconds := anObject
]
