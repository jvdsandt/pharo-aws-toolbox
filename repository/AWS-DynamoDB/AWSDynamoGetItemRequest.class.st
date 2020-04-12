Class {
	#name : #AWSDynamoGetItemRequest,
	#superclass : #AWSDynamoRequest,
	#instVars : [
		'key',
		'tableName',
		'projectionExpression',
		'returnConsumedCapacity'
	],
	#category : #'AWS-DynamoDB'
}

{ #category : #accessing }
AWSDynamoGetItemRequest >> basicKey: aDictionary [
	key := aDictionary
]

{ #category : #accessing }
AWSDynamoGetItemRequest >> key [
	^ key
]

{ #category : #accessing }
AWSDynamoGetItemRequest >> key: keyValueCollection [
	| newDict |
	newDict := Dictionary new.
	keyValueCollection associationsDo: [ :each |
		newDict at: each key put: each value asDynamoAttributeValue ].
	self basicKey: newDict
]

{ #category : #'as yet unclassified' }
AWSDynamoGetItemRequest >> neoJsonOn: neoJSONWriter [
	neoJSONWriter writeMapStreamingDo: [ :jsonMapWriter |
		jsonMapWriter 
			writeKey: 'TableName' value: tableName;
			writeKey: 'Key' value: key.
		projectionExpression ifNotNil: [
			jsonMapWriter writeKey: 'ProjectionExpression' value: projectionExpression ].
		returnConsumedCapacity ifNotNil: [ 
			jsonMapWriter writeKey: 'ReturnConsumedCapacity' value: returnConsumedCapacity ] ]
]

{ #category : #accessing }
AWSDynamoGetItemRequest >> operationName [

	^ 'GetItem'
]

{ #category : #accessing }
AWSDynamoGetItemRequest >> projectionExpression [
	^ projectionExpression
]

{ #category : #accessing }
AWSDynamoGetItemRequest >> projectionExpression: anObject [
	projectionExpression := anObject
]

{ #category : #accessing }
AWSDynamoGetItemRequest >> returnConsumedCapacity [
	^ returnConsumedCapacity
]

{ #category : #accessing }
AWSDynamoGetItemRequest >> returnConsumedCapacity: anObject [
	returnConsumedCapacity := anObject
]

{ #category : #accessing }
AWSDynamoGetItemRequest >> tableName [
	^ tableName
]

{ #category : #accessing }
AWSDynamoGetItemRequest >> tableName: aString [
	tableName := aString
]
