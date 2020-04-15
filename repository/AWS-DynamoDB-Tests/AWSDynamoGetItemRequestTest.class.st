Class {
	#name : #AWSDynamoGetItemRequestTest,
	#superclass : #TestCase,
	#category : #'AWS-DynamoDB-Tests'
}

{ #category : #tests }
AWSDynamoGetItemRequestTest >> testBinaryDataType [

	| request |
	
	request := AWSDynamoGetItemRequest new
		tableName: 'T1';
		key: (Array  
			with: 'F1' -> 'V1'
			with: 'F2' -> #[ 10 120 30 40 40 60 70 80 90 100 200 210 220 230 240 250 ]);
		yourself.
	self 
		awsJsonAssert: request
		equals: '{
	"Key":{
		"F1":{"S":"V1"},
		"F2":{"B":"CngeKCg8RlBaZMjS3Obw+g=="}
	},
	"TableName":"T1"
}'
]

{ #category : #tests }
AWSDynamoGetItemRequestTest >> testEmptyRequest [

	| request |
	
	request := AWSDynamoGetItemRequest new.
	self assert: '{}' equals: request asJsonString
]

{ #category : #tests }
AWSDynamoGetItemRequestTest >> testHttpRequest [

	| request httpRequest |
	
	request := AWSDynamoGetItemRequest new
		tableName: 'T1';
		addKeyEntry: 'A1' value: 'Amazon DynamoDB';
		addKeyEntry: 'A2' value: 'Bla bla';
		yourself.
	httpRequest := request asHttpRequest: 'https://dynamodb.eu-west-1.amazonaws.com'.
	
	self assert: httpRequest method equals: 'POST'.
	self assert: (httpRequest headers at: 'X-Amz-Target') equals: 'DynamoDB_20120810.GetItem'.
	self assert: httpRequest contents equals: request asJsonString.
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
		awsJsonAssert: request
		equals: '{"Key":{"F1":{"S":"V1"},"F2":{"S":"V2"}},"TableName":"T1"}'
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
		awsJsonAssert: request
		equals: '{"Key":{"F1":{"S":"V1"},"F4":{"BOOL":true},"F2":{"N":"123"},"F5":{"NULL":true},"F3":{"N":"345.678"}},"TableName":"T1"}'
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
		awsJsonAssert: request
		equals: '{"Key":{"Subject":{"S":"How?"},"ForumName":{"S":"Amazon DynamoDB"}},"TableName":"Thread"}'
]
