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
AWSDynamoGetItemResponse >> consumedCapacity [
	^ consumedCapacity
]

{ #category : #accessing }
AWSDynamoGetItemResponse >> item [
	^ item
]
