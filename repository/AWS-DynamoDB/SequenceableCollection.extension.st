Extension { #name : #SequenceableCollection }

{ #category : #'*AWS-DynamoDB' }
SequenceableCollection >> asDynamoAttributeValue [
	^ AWSDynamoAttributeValue list: self
]
