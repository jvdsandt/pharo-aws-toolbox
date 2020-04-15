Class {
	#name : #AWSDynamoRequestTest,
	#superclass : #TestCase,
	#category : #'AWS-DynamoDB-Tests'
}

{ #category : #tests }
AWSDynamoRequestTest >> testCreateTableRequest [

	| request |
	
	request := AWSDynamoCreateTableRequest new
		tableName: 'T1';
		addAttribute: 'A1' type: 'N';
		addAttribute: 'A2' type: 'S';
		keySchema: (Array 
			with: (AWSDynamoKeySchemaElement name: 'A1' keyType: 'HASH')
			with: (AWSDynamoKeySchemaElement name: 'A2' keyType: 'RANGE'));
		yourself.
		
	self awsJsonAssert: request
		equals: '{
		"TableName":"T1",
		"AttributeDefinitions":[
			{"AttributeName":"A1","AttributeType":"N"},
			{"AttributeName":"A2","AttributeType":"S"}],
		"KeySchema":[
			{"AttributeName":"A1","KeyType":"HASH"},
			{"AttributeName":"A2","KeyType":"RANGE"}],
		"ProvisionedThroughput":{
			"WriteCapacityUnits":5,
			"ReadCapacityUnits":5
		}
	}'
]

{ #category : #tests }
AWSDynamoRequestTest >> testDeleteItemRequest [

	| request |
	
	request := AWSDynamoDeleteItemRequest new
		tableName: 'T1';
		key: (Array with: 'Year' -> 2000 with: 'Company' -> 'Google');
		returnOldValues;
		yourself.
		
	self awsJsonAssert: request
		equals: '{"Key":{"Company":{"S":"Google"},"Year":{"N":"2000"}},"TableName":"T1","ReturnValues":"ALL_OLD"}' 
]

{ #category : #tests }
AWSDynamoRequestTest >> testPutItemRequest [

	| request |
	
	request := AWSDynamoPutItemRequest new
		tableName: 'T1';
		addItemEntry: 'Year' value: 2000;
		addItemEntry: 'Company' value: 'Google';
		addItemEntry: 'Description' value: 'Bla';
		yourself.
		
	self awsJsonAssert: request
		equals: '{
	"TableName":"T1",
	"Item":{
		"Company":{"S":"Google"},
		"Description":{"S":"Bla"},
		"Year":{"N":"2000"}
	}
}'
]
