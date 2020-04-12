Class {
	#name : #AWSDynamoGetItemRequestTest,
	#superclass : #TestCase,
	#category : #'AWS-DynamoDB-Tests'
}

{ #category : #'as yet unclassified' }
AWSDynamoGetItemRequestTest >> jsonAssert: object equals: expectedJsonString [

	| jsonString |
	
	jsonString := object asJsonString.
	self assert: (NeoJSONReader fromString: jsonString)
		equals: (NeoJSONReader fromString: expectedJsonString)
]

{ #category : #tests }
AWSDynamoGetItemRequestTest >> testEmptyRequest [

	| request |
	
	request := AWSDynamoGetItemRequest new.
	self assert: '{}' equals: request asJsonString
]

{ #category : #tests }
AWSDynamoGetItemRequestTest >> testKeyAsAssociationArray [

	| request |
	
	request := AWSDynamoGetItemRequest new
		tableName: 'T1';
		key: (Array  
			with: 'F1' -> 'V1'
			with: 'F2' -> 'V2');
		yourself.
	self 
		jsonAssert: request
		equals: '{"key":{"F2":{"S":"V2"},"F1":{"S":"V1"}},"tableName":"T1"}'
]

{ #category : #tests }
AWSDynamoGetItemRequestTest >> testPrimitiveDataTypes [

	| request |
	
	request := AWSDynamoGetItemRequest new
		tableName: 'T1';
		key: (Array  
			with: 'F1' -> 'V1'
			with: 'F2' -> 123
			with: 'F3' -> 345.678
			with: 'F4' -> true
			with: 'F5' -> nil);
		yourself.
	self 
		jsonAssert: request
		equals: '{"key":{"F1":{"S":"V1"},"F4":{"BOOL":true},"F2":{"N":"123"},"F5":{"NULL":true},"F3":{"N":"345.678"}},"tableName":"T1"}'
]

{ #category : #tests }
AWSDynamoGetItemRequestTest >> testSimpleRequest [

	| request |
	
	request := AWSDynamoGetItemRequest new
		tableName: 'Thread';
		key: (Dictionary  
			with: 'ForumName' -> 'Amazon DynamoDB'
			with: 'Subject' -> 'How?');
		yourself.
	self 
		jsonAssert: request
		equals: '{"key":{"Subject":{"S":"How?"},"ForumName":{"S":"Amazon DynamoDB"}},"tableName":"Thread"}'
]
