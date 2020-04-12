Class {
	#name : #AWSDynamoAttributeValue,
	#superclass : #Object,
	#instVars : [
		'type',
		'value'
	],
	#category : #'AWS-DynamoDB-DataTypes'
}

{ #category : #resources }
AWSDynamoAttributeValue class >> base64Encoder [

	^ ZnBase64Encoder new
]

{ #category : #'instance creation' }
AWSDynamoAttributeValue class >> binary: aByteArray [

	^ self type: 'B' value: (self base64Encoder encode: aByteArray)
]

{ #category : #'instance creation' }
AWSDynamoAttributeValue class >> boolean: b [

	^ self type: 'BOOL' value: b
]

{ #category : #'instance creation' }
AWSDynamoAttributeValue class >> null [

	^ self type: 'NULL' value: true
]

{ #category : #'instance creation' }
AWSDynamoAttributeValue class >> number: aNumber [

	^ self type: 'N' value: aNumber asString
]

{ #category : #'instance creation' }
AWSDynamoAttributeValue class >> string: aValue [

	^ self type: 'S' value: aValue
]

{ #category : #'instance creation' }
AWSDynamoAttributeValue class >> type: aTypeString value: aValueString [

	^ self new initWithType: aTypeString value: aValueString
]

{ #category : #accessing }
AWSDynamoAttributeValue >> attributeType [
	^ type
]

{ #category : #accessing }
AWSDynamoAttributeValue >> attributeValue [
	^ value
]

{ #category : #initialization }
AWSDynamoAttributeValue >> initWithType: aTypeString value: aValueString [

	type := aTypeString.
	value := aValueString
]

{ #category : #iterating }
AWSDynamoAttributeValue >> keysAndValuesDo: aBlock [
	aBlock value: type value: value
]

{ #category : #printing }
AWSDynamoAttributeValue >> neoJsonOn: neoJSONWriter [
	neoJSONWriter writeMap: self
]

{ #category : #printing }
AWSDynamoAttributeValue >> printOn: aStream [

	type printOn: aStream.
	aStream nextPutAll: ' -> '.
	value printOn: aStream
	
]
