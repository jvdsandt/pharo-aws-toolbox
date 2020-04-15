Extension { #name : #Collection }

{ #category : #'*AWS-DynamoDB' }
Collection >> asDynamoAttributeValues [
	"Convert the receiver into a DynamoDB AttributeValue dictionary. With the
	attribute name as key and an AWSDynamoAttributeValue as value."
	
	| newDict |
	newDict := Dictionary new.
	self associationsDo: [ :each |
		newDict at: each key put: each value asDynamoAttributeValue ].
	^ newDict
]
