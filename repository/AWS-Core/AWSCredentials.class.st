dd"
I am an immutable data object for storing AWS credentials.
"
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
	"Try to get the accessKeyId ans secretKey from the default profile in the standard AWS config files."

	^ AWSEnvironment defaultCredentials
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

{ #category : #printing }
AWSCredentials >> printOn: stream [
	super printOn: stream.
	stream nextPut: $(; print: self accessKeyId; nextPut: $)	
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
