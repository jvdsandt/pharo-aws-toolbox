Class {
	#name : #AWSIntegrationTestResource,
	#superclass : #TestResource,
	#classVars : [
		'Credentials',
		'RegionName'
	],
	#category : #'AWS-Core-Tests'
}

{ #category : #accessing }
AWSIntegrationTestResource class >> credentials [

	^ Credentials ifNil: [ AWSCredentials default]
]

{ #category : #accessing }
AWSIntegrationTestResource class >> credentials: awsCredentials [

	Credentials := awsCredentials
]

{ #category : #accessing }
AWSIntegrationTestResource class >> regionName [

	^ RegionName ifNil: [ AWSEnvironment defaultRegionName ]
]

{ #category : #accessing }
AWSIntegrationTestResource class >> regionName: aString [

	RegionName := aString
]

{ #category : #accessing }
AWSIntegrationTestResource >> credentials [

	^ self class credentials
]

{ #category : #testing }
AWSIntegrationTestResource >> isAvailable [ 

	^ self credentials notNil and: [ self regionName notNil ]
]

{ #category : #accessing }
AWSIntegrationTestResource >> regionName [ 

	^ self class regionName
]
