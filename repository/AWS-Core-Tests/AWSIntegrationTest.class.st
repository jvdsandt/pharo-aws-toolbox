Class {
	#name : #AWSIntegrationTest,
	#superclass : #TestCase,
	#classVars : [
		'Credentials',
		'RegionName'
	],
	#category : #'AWS-Core-Tests'
}

{ #category : #accessing }
AWSIntegrationTest class >> credentials [

	^ Credentials ifNil: [ AWSEnvironment defaultCredentials ]
]

{ #category : #accessing }
AWSIntegrationTest class >> credentials: awsCredentials [

	Credentials := awsCredentials
]

{ #category : #accessing }
AWSIntegrationTest class >> regionName [

	^ RegionName ifNil: [ AWSEnvironment defaultRegionName ]
]

{ #category : #accessing }
AWSIntegrationTest class >> regionName: aString [

	RegionName := aString
]
