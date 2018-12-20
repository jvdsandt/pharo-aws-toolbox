Class {
	#name : #AWSLambdaErrorTest,
	#superclass : #TestCase,
	#category : #'AWS-Lambda-Runtime-Tests'
}

{ #category : #tests }
AWSLambdaErrorTest >> testToJson [

	| error |
	
	error := AWSLambdaError type: 'MajorError' message: 'Out of connections'.
	self assert: '{"errorType":"MajorError","errorMessage":"Out of connections"}' equals: error asJsonString
]
