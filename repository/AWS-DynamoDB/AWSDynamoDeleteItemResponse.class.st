Class {
	#name : #AWSDynamoDeleteItemResponse,
	#superclass : #AWSDynamoResponse,
	#instVars : [
		'attributes',
		'consumedCapacity'
	],
	#category : #'AWS-DynamoDB-Requests'
}

{ #category : #accessing }
AWSDynamoDeleteItemResponse >> attributes [
	^ attributes
]

{ #category : #accessing }
AWSDynamoDeleteItemResponse >> consumedCapacity [
	^ consumedCapacity
]

{ #category : #accessing }
AWSDynamoDeleteItemResponse >> consumedCapacity: anObject [
	consumedCapacity := anObject
]
