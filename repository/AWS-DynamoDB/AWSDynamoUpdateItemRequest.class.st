Class {
	#name : #AWSDynamoUpdateItemRequest,
	#superclass : #AWSDynamoRequest,
	#instVars : [
		'key',
		'tableName',
		'updateExpression',
		'conditionExpression',
		'expressionAttributeValues',
		'returnValues'
	],
	#category : #'AWS-DynamoDB-Requests'
}

{ #category : #accessing }
AWSDynamoUpdateItemRequest >> operationName [
	^ 'UpdateItem'
]
