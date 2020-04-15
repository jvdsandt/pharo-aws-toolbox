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

{ #category : #adding }
AWSDynamoGetItemRequest >> addKeyEntry: attribName value: attribValue [
	self key at: attribName put: attribValue asDynamoAttributeValue
]

{ #category : #accessing }
AWSDynamoGetItemRequest >> key [
	^ key ifNil: [ key := Dictionary new ]
]

{ #category : #accessing }
AWSDynamoGetItemRequest >> key: keyValueCollection [
	key := keyValueCollection asDynamoAttributeValues
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
AWSDynamoGetItemRequest >> returnConsumedCapacity: aString [
	"INDEXES | TOTAL | NONE"
	returnConsumedCapacity := aString
]

{ #category : #accessing }
AWSDynamoGetItemRequest >> tableName [
	^ tableName
]

{ #category : #accessing }
AWSDynamoGetItemRequest >> tableName: aString [
	tableName := aString
]
