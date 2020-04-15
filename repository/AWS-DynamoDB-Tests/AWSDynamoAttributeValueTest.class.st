Class {
	#name : #AWSDynamoAttributeValueTest,
	#superclass : #TestCase,
	#category : #'AWS-DynamoDB-Tests'
}

{ #category : #tests }
AWSDynamoAttributeValueTest >> testBinarySet [

	| bs av |
	
	bs := Array with: #[ 123 ] with: #[ 10 20 30 ] with: #[ 200 201 203 255 ].
	av := AWSDynamoAttributeValue binarySet: bs.
	self assert: av attributeType equals: 'BS'.
	self assert: av asValue equals: bs
]

{ #category : #tests }
AWSDynamoAttributeValueTest >> testBoolean [

	| av |
	
	av := AWSDynamoAttributeValue boolean: true.
	self assert: av attributeType equals: 'BOOL'.
	self assert: av asValue equals: true.
	
	av := AWSDynamoAttributeValue boolean: false.
	self assert: av attributeType equals: 'BOOL'.
	self assert: av asValue equals: false.
]

{ #category : #tests }
AWSDynamoAttributeValueTest >> testByteArray [

	| av |
	
	av := AWSDynamoAttributeValue binary: #[ 1 2 3 4 250 ].
	self assert: av attributeType equals: 'B'.
	self assert: av attributeValue equals: 'AQIDBPo='.
	self assert: av asValue equals: #[ 1 2 3 4 250 ]
]

{ #category : #tests }
AWSDynamoAttributeValueTest >> testList [

	| list av |
	
	list := #( 'text' 123 true nil false ).
	
	av := AWSDynamoAttributeValue list: list.
	self assert: av attributeType equals: 'L'.
	self assert: av asValue equals: list
]

{ #category : #tests }
AWSDynamoAttributeValueTest >> testMap [

	| map av |
	
	map := Dictionary new
		at: 'f1' put: 123;
		at: 'f2' put: 'some text';
		at: 'f3' put: (Dictionary new
			at: 'f3.1' put: 'tezt';
			at: 'f3.2' put: true;
			yourself);
		yourself.
	
	av := AWSDynamoAttributeValue map: map.
	self assert: av attributeType equals: 'M'.
	self assert: av asValue equals: map
]

{ #category : #tests }
AWSDynamoAttributeValueTest >> testNil [

	| av |
	
	av := AWSDynamoAttributeValue null.
	self assert: av attributeType equals: 'NULL'.
	self assert: av asValue equals: nil
]

{ #category : #tests }
AWSDynamoAttributeValueTest >> testNumber [

	| av |
	
	av := AWSDynamoAttributeValue number: 123.
	self assert: av attributeType equals: 'N'.
	self assert: av asValue equals: 123.

	av := AWSDynamoAttributeValue number: 123.456.
	self assert: av attributeType equals: 'N'.
	self assert: (av asValue between: 123.4559 and: 123.4561)
]

{ #category : #tests }
AWSDynamoAttributeValueTest >> testNumberSet [

	| av |
	
	av := AWSDynamoAttributeValue numberSet: #( 123 456 789 ).
	self assert: av attributeType equals: 'NS'.
	self assert: av asValue equals: #( 123 456 789 )
]

{ #category : #tests }
AWSDynamoAttributeValueTest >> testString [

	| av |
	
	av := AWSDynamoAttributeValue string: 'Hi'.
	self assert: av attributeType equals: 'S'.
	self assert: av asValue equals: 'Hi'
]
