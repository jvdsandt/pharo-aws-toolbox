Class {
	#name : #AWSDynamoGetItemRequest,
	#superclass : #AWSDynamoRequest,
	#instVars : [
		'key',
		'tableName',
		'projectionExpression',
		'returnConsumedCapacity'
	],
	#category : #'AWS-DynamoDB-Requests'
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
