Class {
	#name : #AWSDynamoDeleteItemRequest,
	#superclass : #AWSDynamoRequest,
	#instVars : [
		'key',
		'tableName',
		'returnConsumedCapacity',
		'returnValues'
	],
	#category : #'AWS-DynamoDB-Requests'
}

{ #category : #accessing }
AWSDynamoDeleteItemRequest >> key [
	^ key
]

{ #category : #accessing }
AWSDynamoDeleteItemRequest >> key: anObject [
	key := anObject
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
AWSDynamoDeleteItemRequest >> returnConsumedCapacity: anObject [
	returnConsumedCapacity := anObject
]

{ #category : #accessing }
AWSDynamoDeleteItemRequest >> returnValues [
	^ returnValues
]

{ #category : #accessing }
AWSDynamoDeleteItemRequest >> returnValues: anObject [
	returnValues := anObject
]

{ #category : #accessing }
AWSDynamoDeleteItemRequest >> tableName [
	^ tableName
]

{ #category : #accessing }
AWSDynamoDeleteItemRequest >> tableName: anObject [
	tableName := anObject
]
