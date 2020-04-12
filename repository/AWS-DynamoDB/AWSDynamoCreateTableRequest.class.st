Class {
	#name : #AWSDynamoCreateTableRequest,
	#superclass : #AWSDynamoRequest,
	#instVars : [
		'tableName',
		'attributeDefinitions',
		'keySchema',
		'provisionedThroughput'
	],
	#category : #'AWS-DynamoDB-Requests'
}

{ #category : #adding }
AWSDynamoCreateTableRequest >> addAttribute: aName type: attribType [

	^ attributeDefinitions add: (AWSDynamoAttributeDefinition name: aName type: attribType)
]

{ #category : #adding }
AWSDynamoCreateTableRequest >> addBinaryAttribute: aName [

	^ self addAttribute: aName type: 'B'
]

{ #category : #adding }
AWSDynamoCreateTableRequest >> addNumberAttribute: aName [

	^ self addAttribute: aName type: 'N'
]

{ #category : #adding }
AWSDynamoCreateTableRequest >> addStringAttribute: aName [

	^ self addAttribute: aName type: 'S'
]

{ #category : #accessing }
AWSDynamoCreateTableRequest >> attributeDefinitions [
	^ attributeDefinitions
]

{ #category : #accessing }
AWSDynamoCreateTableRequest >> attributeDefinitions: anObject [
	attributeDefinitions := anObject
]

{ #category : #initialization }
AWSDynamoCreateTableRequest >> initialize [

	super initialize.
	attributeDefinitions := OrderedCollection new.
	provisionedThroughput := Dictionary new.
	self readCapacityUnits: 5.
	self writeCapacityUnits: 5.
]

{ #category : #accessing }
AWSDynamoCreateTableRequest >> keySchema [
	^ keySchema
]

{ #category : #accessing }
AWSDynamoCreateTableRequest >> keySchema: anObject [
	keySchema := anObject
]

{ #category : #accessing }
AWSDynamoCreateTableRequest >> operationName [

	^ 'CreateTable'
]

{ #category : #accessing }
AWSDynamoCreateTableRequest >> provisionedThroughput [
	^ provisionedThroughput
]

{ #category : #accessing }
AWSDynamoCreateTableRequest >> provisionedThroughput: anObject [
	provisionedThroughput := anObject
]

{ #category : #accessing }
AWSDynamoCreateTableRequest >> readCapacityUnits: anInteger [
	provisionedThroughput at: 'ReadCapacityUnits' put: anInteger
]

{ #category : #accessing }
AWSDynamoCreateTableRequest >> tableName [
	^ tableName
]

{ #category : #accessing }
AWSDynamoCreateTableRequest >> tableName: anObject [
	tableName := anObject
]

{ #category : #accessing }
AWSDynamoCreateTableRequest >> writeCapacityUnits: anInteger [
	provisionedThroughput at: 'WriteCapacityUnits' put: anInteger
]
