Class {
	#name : #AWSDynamoTable,
	#superclass : #Object,
	#instVars : [
		'service',
		'tableName'
	],
	#category : #'AWS-DynamoDB-Table'
}

{ #category : #actions }
AWSDynamoTable >> getItem: key [

	| response |
	
	response := service getItem: (AWSDynamoGetItemRequest new
		tableName: self tableName;
		key: key;
		yourself).
]

{ #category : #actions }
AWSDynamoTable >> save: anItem [
	service putItem: (AWSDynamoPutItemRequest new
		tableName: self tableName;
		item: anItem;
		yourself)
]

{ #category : #accessing }
AWSDynamoTable >> tableName [
	^ tableName
]
