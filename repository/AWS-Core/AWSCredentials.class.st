"
I am an immutable data object for storing AWS credentials.
"
Class {
	#name : #AWSCredentials,
	#superclass : #Object,
	#instVars : [
		'accessKeyId',
		'secretKey',
		'sessionToken',
		'expirationTime',
		'provider'
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
	"self default"

	^ AWSEnvironment defaultCredentials
]

{ #category : #'instance creation' }
AWSCredentials class >> fromJsonStream: aStream [

	^ (NeoJSONReader on: aStream) nextAs: self
]

{ #category : #'instance creation' }
AWSCredentials class >> fromJsonString: aString [

	^ self fromJsonStream: aString readStream
]

{ #category : #accessing }
AWSCredentials class >> neoJsonMapping: mapper [
	mapper
		for: self
		do: [ :mapping | 
			mapping
				mapInstVar: #accessKeyId to: #AccessKeyId;
				mapInstVar: #secretKey to: #SecretAccessKey;
				mapInstVar: #sessionToken to: #Token.
			(mapping mapInstVar: #expirationTime to: #Expiration)
				valueSchema: DateAndTime ].
	mapper
		for: DateAndTime
		customDo: [ :mapping | 
			mapping decoder: [ :string | DateAndTime fromString: string ].
			mapping encoder: [ :dateAndTime | dateAndTime printString ] ]
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

{ #category : #accessing }
AWSCredentials >> expirationTime [

	^expirationTime
]

{ #category : #comparing }
AWSCredentials >> hash [

	^ accessKeyId hash bitXor: secretKey hash
]

{ #category : #testing }
AWSCredentials >> isExpired [
	^ self expirationTime notNil
		and: [ self expirationTime < DateAndTime now ]
]

{ #category : #printing }
AWSCredentials >> printOn: stream [
	super printOn: stream.
	stream nextPut: $(; print: self accessKeyId; nextPut: $)	
]

{ #category : #accessing }
AWSCredentials >> provider [
	^provider
]

{ #category : #accessing }
AWSCredentials >> provider: anAWSCredentialsProvider [

	provider:= anAWSCredentialsProvider 
]

{ #category : #actions }
AWSCredentials >> refresh [
	self provider	
		ifNotNil: [:prov | self refreshWith: prov getCredentials ]
		ifNil: [ ^ self error: 'Not possible to refresh AWS Credentials.' ]
]

{ #category : #actions }
AWSCredentials >> refreshWith: awsCredentials [
	self
		setAccessKeyId: awsCredentials accessKeyId
		secretKey: awsCredentials secretKey
		sessionToken: awsCredentials sessionToken
		expirationTime: awsCredentials expirationTime
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

{ #category : #initialization }
AWSCredentials >> setAccessKeyId: aKeyId secretKey: aSecretKey sessionToken: aToken expirationTime: aDateTime [

	self setAccessKeyId: aKeyId secretKey: aSecretKey sessionToken: aToken.
	expirationTime := aDateTime
]
