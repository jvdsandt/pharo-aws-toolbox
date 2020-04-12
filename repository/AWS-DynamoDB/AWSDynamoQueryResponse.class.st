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
