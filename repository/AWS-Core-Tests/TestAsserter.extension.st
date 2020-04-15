Extension { #name : #TestAsserter }

{ #category : #'*AWS-Core-Tests' }
TestAsserter >> awsJsonAssert: object equals: expectedJsonString [

	| jsonString |
	
	jsonString := object asJsonString.
	self awsJsonStringAssert: jsonString equals: expectedJsonString
]

{ #category : #'*AWS-Core-Tests' }
TestAsserter >> awsJsonStringAssert: jsonString equals: expectedJsonString [

	self assert: (NeoJSONReader fromString: jsonString)
		equals: (NeoJSONReader fromString: expectedJsonString)
]
