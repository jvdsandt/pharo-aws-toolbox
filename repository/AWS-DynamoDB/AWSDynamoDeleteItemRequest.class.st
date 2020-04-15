Class {
	#name : #AWSDynamoDeleteItemRequest,
	#superclass : #AWSDynamoRequest,
	#instVars : [
		'key',
		'tableName',
		'conditionExpression',
		'expressionAttributeNames',
		'expressionAttributeValues',
		'returnConsumedCapacity',
		'returnValues'
	],
	#category : #'AWS-DynamoDB-Requests'
}

{ #category : #adding }
AWSDynamoDeleteItemRequest >> addKeyEntry: attribName value: attribValue [
	self key at: attribName put: attribValue asDynamoAttributeValue
]

{ #category : #accessing }
AWSDynamoDeleteItemRequest >> conditionExpression [
	^ conditionExpression
]

{ #category : #accessing }
AWSDynamoDeleteItemRequest >> conditionExpression: anObject [
	conditionExpression := anObject
]

{ #category : #accessing }
AWSDynamoDeleteItemRequest >> expressionAttributeNames [
	^ expressionAttributeNames
]

{ #category : #accessing }
AWSDynamoDeleteItemRequest >> expressionAttributeNames: anObject [
	expressionAttributeNames := anObject
]

{ #category : #accessing }
AWSDynamoDeleteItemRequest >> expressionAttributeValues [
	^ expressionAttributeValues
]

{ #category : #accessing }
AWSDynamoDeleteItemRequest >> expressionAttributeValues: keyValueCollection [
	expressionAttributeValues := keyValueCollection asDynamoAttributeValues
]

{ #category : #accessing }
AWSDynamoDeleteItemRequest >> key [
	^ key ifNil: [ key := Dictionary new ]
]

{ #category : #accessing }
AWSDynamoDeleteItemRequest >> key: keyValueCollection [
	key := keyValueCollection asDynamoAttributeValues
]

{ #category : #accessing }
AWSDynamoDeleteItemRequest >> operationName [
	^ 'DeleteItem'
]

{ #category : #accessing }
AWSDynamoDeleteItemRequest >> returnConsumedCapacity [
	^ returnConsumedCapacity
]

{ #category : #accessing }
AWSDynamoDeleteItemRequest >> returnConsumedCapacity: aString [
	"INDEXES | TOTAL | NONE"
	returnConsumedCapacity := aString
]

{ #category : #convenience }
AWSDynamoDeleteItemRequest >> returnOldValues [
	self returnValues: 'ALL_OLD'
]

{ #category : #accessing }
AWSDynamoDeleteItemRequest >> returnValues [
	^ returnValues
]

{ #category : #accessing }
AWSDynamoDeleteItemRequest >> returnValues: aString [
	"NONE | ALL_OLD"
	returnValues := aString
]

{ #category : #accessing }
AWSDynamoDeleteItemRequest >> tableName [
	^ tableName
]

{ #category : #accessing }
AWSDynamoDeleteItemRequest >> tableName: anObject [
	tableName := anObject
]
