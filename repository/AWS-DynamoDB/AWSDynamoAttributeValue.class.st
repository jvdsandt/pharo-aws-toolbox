Class {
	#name : #AWSDynamoAttributeValue,
	#superclass : #Object,
	#instVars : [
		'type',
		'value'
	],
	#classVars : [
		'Converters'
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
AWSDynamoAttributeValue class >> binarySet: aByteArrayColl [

	^ self type: 'BS' value: (aByteArrayColl collect: [ :each | self base64Encoder encode: each ])
]

{ #category : #'instance creation' }
AWSDynamoAttributeValue class >> boolean: b [

	^ self type: 'BOOL' value: b
]

{ #category : #initialization }
AWSDynamoAttributeValue class >> clearConverters [

	^ Converters := nil
]

{ #category : #converting }
AWSDynamoAttributeValue class >> convert: dynamoValue type: dynamoType [

	^ (self converters at: dynamoType) value: dynamoValue
]

{ #category : #initialization }
AWSDynamoAttributeValue class >> converters [

	^ Converters ifNil: [ Converters := self createConverters ]
]

{ #category : #initialization }
AWSDynamoAttributeValue class >> createConverters [

	^ Dictionary new
		at: 'S' put: [ :v | v ];
		at: 'SS' put: [ :v | v ];
		at: 'N' put: [ :v | Number readFrom: v readStream ];
		at: 'NS' put: [ :v | v collect: [ :each | Number readFrom: each readStream ] ];
		at: 'BOOL' put: [ :v | v ];
		at: 'NULL' put: [ :v | nil ];
		at: 'B' put: [ :v | self base64Encoder decode: v ];
		at: 'BS' put: [ :v | v collect: [ :each | self base64Encoder decode: each ] ];
		at: 'L' put: [ :v | v collect: [ :each | each asValue ] ];
		at: 'M' put: [ :v | v collect: [ :each | each asValue ] ];
		yourself
]

{ #category : #'instance creation' }
AWSDynamoAttributeValue class >> list: aCollection [
	"A list is similar to a JSON array."
	
	^ self type: 'L' value: (
			aCollection collect: [ :each | each asDynamoAttributeValue ])
]

{ #category : #'instance creation' }
AWSDynamoAttributeValue class >> map: aDictionary [
	"Map document type (similar to a JSON object)"
	
	^ self type: 'M' value: aDictionary asDynamoAttributeValues
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
AWSDynamoAttributeValue class >> numberSet: aNumberColl [

	^ self type: 'NS' value: (aNumberColl collect: [ :each | each asString ])
]

{ #category : #'instance creation' }
AWSDynamoAttributeValue class >> string: aValue [

	^ self type: 'S' value: aValue
]

{ #category : #'instance creation' }
AWSDynamoAttributeValue class >> stringSet: aStringColl [

	^ self type: 'SS' value: aStringColl
]

{ #category : #'instance creation' }
AWSDynamoAttributeValue class >> type: aTypeString value: aValueString [

	^ self new initWithType: aTypeString value: aValueString
]

{ #category : #converting }
AWSDynamoAttributeValue >> asDynamoAttributeValue [
	^ self
]

{ #category : #converting }
AWSDynamoAttributeValue >> asValue [
	^ self converter value: value
]

{ #category : #accessing }
AWSDynamoAttributeValue >> attributeType [
	^ type
]

{ #category : #accessing }
AWSDynamoAttributeValue >> attributeValue [
	^ value
]

{ #category : #accessing }
AWSDynamoAttributeValue >> converter [
	^ self class converters at: type
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
