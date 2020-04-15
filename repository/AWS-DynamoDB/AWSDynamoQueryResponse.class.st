Class {
	#name : #AWSDynamoQueryResponse,
	#superclass : #AWSDynamoResponse,
	#instVars : [
		'consumedCapacity',
		'count',
		'items',
		'lastEvaluatedKey',
		'scannedCount'
	],
	#category : #'AWS-DynamoDB-Requests'
}

{ #category : #accessing }
AWSDynamoQueryResponse class >> neoJsonMapping: mapper [

	mapper for: self do: [ :mapping |
		self instVarNames do: [ :eachName |
			mapping mapInstVar: eachName to: eachName capitalized ].
		(mapping mapInstVar: #items to: 'Items') valueSchema: #ArrayOfAWSDynamoItem.
		(mapping mapInstVar: #lastEvaluatedKey to: 'LastEvaluatedKey') valueSchema: AWSDynamoItem ].
	
	mapper for: #ArrayOfAWSDynamoItem customDo: [ :mapping |
		mapping listOfElementSchema: AWSDynamoItem ]
]

{ #category : #accessing }
AWSDynamoQueryResponse >> consumedCapacity [
	^ consumedCapacity
]

{ #category : #accessing }
AWSDynamoQueryResponse >> count [
	^ count
]

{ #category : #accessing }
AWSDynamoQueryResponse >> items [
	^ items
]

{ #category : #accessing }
AWSDynamoQueryResponse >> lastEvaluatedKey [
	^ lastEvaluatedKey
]

{ #category : #accessing }
AWSDynamoQueryResponse >> scannedCount [
	^ scannedCount
]
