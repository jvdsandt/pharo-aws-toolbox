Class {
	#name : #AWSIntegrationTest,
	#superclass : #TestCase,
	#category : #'AWS-Core-Tests'
}

{ #category : #accessing }
AWSIntegrationTest class >> resources [

	^ Array with: AWSIntegrationTestResource
]

{ #category : #resources }
AWSIntegrationTest >> credentials [

	^ AWSIntegrationTestResource current credentials
]

{ #category : #resources }
AWSIntegrationTest >> regionName [

	^ AWSIntegrationTestResource current regionName
]
