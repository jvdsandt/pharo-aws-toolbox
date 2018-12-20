Class {
	#name : #AWSCredentials,
	#superclass : #Object,
	#instVars : [
		'accessKeyId',
		'secretKey',
		'sessionToken'
	],
	#category : #'AWS-Core-Auth'
}

{ #category : #'instance creation' }
AWSCredentials class >> accessKeyId: aKeyId secretKey: aSecretKey [

	^ self new setAccessKeyId: aKeyId trimmed secretKey: aSecretKey trimmed
]

{ #category : #'instance creation' }
AWSCredentials class >> accessKeyId: aKeyId secretKey: aSecretKey sessionToken: aToken [

	^ self new setAccessKeyId: aKeyId trimmed secretKey: aSecretKey trimmed sessionToken: aToken
]

{ #category : #accessing }
AWSCredentials class >> default [

	^ AWSSignerUtils getCredentialsFromProfile: 'default' ifAbsent: [ nil ]
]

{ #category : #comparing }
AWSCredentials >> = other [

	self == other
		ifTrue: [ ^true ].
	self class = other class
		ifFalse: [ ^false ].
	^ accessKeyId = other accessKeyId and: [
			secretKey = other secretKey and: [ sessionToken = other sessionToken ] ]
]

{ #category : #accessing }
AWSCredentials >> accessKeyId [
	^ accessKeyId
]

{ #category : #comparing }
AWSCredentials >> hash [

	^ accessKeyId hash bitXor: secretKey hash
]

{ #category : #accessing }
AWSCredentials >> secretKey [
	^ secretKey
]

{ #category : #accessing }
AWSCredentials >> sessionToken [
	^ sessionToken
]

{ #category : #initialization }
AWSCredentials >> setAccessKeyId: aKeyId secretKey: aSecretKey [

	accessKeyId := aKeyId.
	secretKey := aSecretKey
]

{ #category : #initialization }
AWSCredentials >> setAccessKeyId: aKeyId secretKey: aSecretKey sessionToken: aToken [

	self setAccessKeyId: aKeyId secretKey: aSecretKey.
	sessionToken := aToken
]
