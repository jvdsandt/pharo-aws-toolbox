Class {
	#name : #AWSDynamoPutItemRequest,
	#superclass : #AWSDynamoRequest,
	#instVars : [
		'tableName',
		'item'
	],
	#category : #'AWS-DynamoDB-Requests'
}

{ #category : #adding }
AWSDynamoPutItemRequest >> addItemEntry: attribName value: attribValue [
	self item at: attribName put: attribValue asDynamoAttributeValue
]

{ #category : #accessing }
AWSDynamoPutItemRequest >> item [
	^ item ifNil: [ item := Dictionary new ]
]

{ #category : #accessing }
AWSDynamoPutItemRequest >> item: keyValueCollection [
	item := keyValueCollection asDynamoAttributeValues
]

{ #category : #accessing }
AWSDynamoPutItemRequest >> operationName [
	^ 'PutItem'
]

{ #category : #accessing }
AWSDynamoPutItemRequest >> tableName [
	^ tableName
]

{ #category : #accessing }
AWSDynamoPutItemRequest >> tableName: anObject [
	tableName := anObject
]
