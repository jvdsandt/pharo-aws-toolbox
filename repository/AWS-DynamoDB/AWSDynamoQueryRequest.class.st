Class {
	#name : #AWSDynamoQueryRequest,
	#superclass : #AWSDynamoRequest,
	#instVars : [
		'tableName',
		'indexName',
		'limit',
		'keyConditionExpression',
		'filterExpression',
		'expressionAttributeValues',
		'projectionExpression'
	],
	#category : #'AWS-DynamoDB-Requests'
}

{ #category : #accessing }
AWSDynamoQueryRequest >> basicExpressionAttributeValues: keyValueCollection [
	expressionAttributeValues := keyValueCollection
]

{ #category : #accessing }
AWSDynamoQueryRequest >> expressionAttributeValues [
	^ expressionAttributeValues
]

{ #category : #accessing }
AWSDynamoQueryRequest >> expressionAttributeValues: keyValueCollection [
	| newDict |
	newDict := Dictionary new.
	keyValueCollection associationsDo: [ :each |
		newDict at: each key put: each value asDynamoAttributeValue ].
	self basicExpressionAttributeValues: newDict
]

{ #category : #accessing }
AWSDynamoQueryRequest >> filterExpression [
	^ filterExpression
]

{ #category : #accessing }
AWSDynamoQueryRequest >> filterExpression: anObject [
	filterExpression := anObject
]

{ #category : #accessing }
AWSDynamoQueryRequest >> indexName [
	^ indexName
]

{ #category : #accessing }
AWSDynamoQueryRequest >> indexName: anObject [
	indexName := anObject
]

{ #category : #accessing }
AWSDynamoQueryRequest >> keyConditionExpression [
	^ keyConditionExpression
]

{ #category : #accessing }
AWSDynamoQueryRequest >> keyConditionExpression: anObject [
	keyConditionExpression := anObject
]

{ #category : #accessing }
AWSDynamoQueryRequest >> limit [
	^ limit
]

{ #category : #accessing }
AWSDynamoQueryRequest >> limit: anObject [
	limit := anObject
]

{ #category : #accessing }
AWSDynamoQueryRequest >> operationName [

	^ 'Query'
]

{ #category : #accessing }
AWSDynamoQueryRequest >> projectionExpression [
	^ projectionExpression
]

{ #category : #accessing }
AWSDynamoQueryRequest >> projectionExpression: anObject [
	projectionExpression := anObject
]

{ #category : #accessing }
AWSDynamoQueryRequest >> tableName [
	^ tableName
]

{ #category : #accessing }
AWSDynamoQueryRequest >> tableName: anObject [
	tableName := anObject
]
