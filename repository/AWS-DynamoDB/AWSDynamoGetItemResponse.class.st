Class {
	#name : #AWSDynamoGetItemResponse,
	#superclass : #AWSDynamoResponse,
	#instVars : [
		'consumedCapacity',
		'item'
	],
	#category : #'AWS-DynamoDB'
}

{ #category : #accessing }
AWSDynamoGetItemResponse class >> neoJsonMapping: mapper [

	mapper for: self do: [ :mapping |
		mapping mapInstVar: #item to: 'Item'.
		mapping mapInstVar: #consumedCapacity to: 'ConsumedCapacity' ].

]

{ #category : #accessing }
AWSDynamoGetItemResponse >> consumedCapacity [
	^ consumedCapacity
]

{ #category : #accessing }
AWSDynamoGetItemResponse >> item [
	^ item
]
