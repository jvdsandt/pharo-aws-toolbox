Extension { #name : #Dictionary }

{ #category : #'*AWS-DynamoDB' }
Dictionary >> asDynamoAttributeValue [ 
	^ AWSDynamoAttributeValue map: self
]
