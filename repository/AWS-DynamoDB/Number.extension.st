Extension { #name : #Number }

{ #category : #'*AWS-DynamoDB' }
Number >> asDynamoAttributeValue [ 

	^ AWSDynamoAttributeValue number: self
]
