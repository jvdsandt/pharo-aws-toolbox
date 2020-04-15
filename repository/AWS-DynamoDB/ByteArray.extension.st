Extension { #name : #ByteArray }

{ #category : #'*AWS-DynamoDB' }
ByteArray >> asDynamoAttributeValue [ 
	^ AWSDynamoAttributeValue binary: self
]
