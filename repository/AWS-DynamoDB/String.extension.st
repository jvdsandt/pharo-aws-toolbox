Extension { #name : #String }

{ #category : #'*AWS-DynamoDB' }
String >> asDynamoAttributeValue [

	^ AWSDynamoAttributeValue string: self
]
