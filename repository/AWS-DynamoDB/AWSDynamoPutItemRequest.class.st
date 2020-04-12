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
AWSDynamoPutItemRequest >> addEntry: attribName value: attribValue [
	self item at: attribName put: attribValue asDynamoAttributeValue
]

{ #category : #accessing }
AWSDynamoPutItemRequest >> basicItem: keyValueCollection [
	item := keyValueCollection
]

{ #category : #accessing }
AWSDynamoPutItemRequest >> item [
	^ item ifNil: [ item := Dictionary new ]
]

{ #category : #accessing }
AWSDynamoPutItemRequest >> item: keyValueCollection [
	| newDict |
	newDict := Dictionary new.
	keyValueCollection associationsDo: [ :each |
		newDict at: each key put: each value asDynamoAttributeValue ].
	self basicItem: newDict
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
