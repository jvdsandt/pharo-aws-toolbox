Class {
	#name : #AWSDynamoItemTest,
	#superclass : #TestCase,
	#category : #'AWS-DynamoDB-Tests'
}

{ #category : #tests }
AWSDynamoItemTest >> testFromComplexDynamoJson [

	| dynamoJson item |
	
	dynamoJson := '{
	"Data":{
		"M":{
			"date":{"S":"20200330"},
			"numbers":{"L":[{"N":"1"},{"N":"2"},{"N":"4"},{"N":"6"},{"N":"7"},{"N":"88"}]},
			"isFinished":{"BOOL":false}
		}
	},
	"Company":{"S":"Google"},
	"Year":{"N":"2000"},
	"Image":{"B":"CngeKCg8RlBaZMjS3Obw+g=="}
}'.
	item := NeoJSONReader fromString: dynamoJson as: AWSDynamoItem.
	self assert: (item at: 'Company') equals: 'Google'.
	self assert: (item at: 'Year') equals: 2000.
	self assert: (item at: 'Image') equals: #[ 10 120 30 40 40 60 70 80 90 100 200 210 220 230 240 250 ].
	self assert: (item at: 'Data') equals: (Dictionary new
		at: 'date' put: '20200330';
		at: 'numbers' put: #( 1 2 4 6 7 88 );
		at: 'isFinished' put: false;
		yourself)
]

{ #category : #tests }
AWSDynamoItemTest >> testFromDynamoJson [

	| dynamoJson item |
	
	dynamoJson := '{"Low":{"N":"47008"},"High":{"N":"47018"}}'.
	
	item := NeoJSONReader fromString: dynamoJson as: AWSDynamoItem.
	self assert: (item at: 'Low') equals: 47008.
	self assert: (item at: 'High') equals: 47018.
]
