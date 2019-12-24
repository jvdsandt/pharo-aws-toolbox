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

{ #category : #adding }
AWSSQSSendMessageRequest >> addAttribute: attribDictionary [

	attributes isNil
		ifTrue: [ attributes := OrderedCollection new ].
	^ attributes add: attribDictionary
]

{ #category : #adding }
AWSSQSSendMessageRequest >> addBinaryAttribute: aName value: aByteArray [

	self addAttribute: (
		Dictionary new
			at: 'Name' put: aName;
			at: 'Value.DataType' put: 'Binary';
			at: 'Value.BinaryValue' put: (ZnBase64Encoder new encode: aByteArray);
			yourself)
]

{ #category : #adding }
AWSSQSSendMessageRequest >> addNumberAttribute: aName value: aNumber [

	self addAttribute: (
		Dictionary new
			at: 'Name' put: aName;
			at: 'Value.DataType' put: 'Number';
			at: 'Value.StringValue' put: aNumber asString;
			yourself)
]

{ #category : #adding }
AWSSQSSendMessageRequest >> addStringAttribute: aName value: aString [

	self addAttribute: (
		Dictionary new
			at: 'Name' put: aName;
			at: 'Value.DataType' put: 'String';
			at: 'Value.StringValue' put: aString;
			yourself)
]

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
	attributes 
		ifNotNil: [ 
			| index |
			index := 1.
			attributes do: [ :eachDict |
				eachDict keysAndValuesDo: [ :eachKey :eachValue | 
					entity at: 'MessageAttribute.', index asString, '.', eachKey put: eachValue ].
				index := index + 1 ] ].

	^ self class convertEntity: entity
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
AWSSQSSendMessageRequest >> delaySeconds: anInteger [
	"Set the number of seconds to postpone the delivery of new messages. Default is zero."

	delaySeconds := anInteger 
]
