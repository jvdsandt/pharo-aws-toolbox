Extension { #name : #Boolean }

{ #category : #'*AWS-DynamoDB' }
Boolean >> asDynamoAttributeValue [ 

	^ AWSDynamoAttributeValue boolean: self
]
