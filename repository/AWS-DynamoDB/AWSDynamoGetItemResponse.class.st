Class {
	#name : #AWSDynamoGetItemResponse,
	#superclass : #AWSDynamoResponse,
	#instVars : [
		'consumedCapacity',
		'item'
	],
	#category : #'AWS-DynamoDB-Requests'
}

{ #category : #accessing }
AWSDynamoGetItemResponse class >> neoJsonMapping: mapper [

	mapper for: self do: [ :mapping |
		self instVarNames do: [ :eachName |
			mapping mapInstVar: eachName to: eachName capitalized ].
		(mapping mapInstVar: #item to: 'Item') valueSchema: AWSDynamoItem ]
]

{ #category : #accessing }
AWSDynamoGetItemResponse >> consumedCapacity [
	^ consumedCapacity
]

{ #category : #accessing }
AWSDynamoGetItemResponse >> item [
	^ item isNil
			ifTrue: [ nil ]
			ifFalse: [ item collect: [ :each | each asValue ] ]
]
