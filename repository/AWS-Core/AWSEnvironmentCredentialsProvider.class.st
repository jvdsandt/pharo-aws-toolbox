Class {
	#name : #AWSEnvironmentCredentialsProvider,
	#superclass : #AWSCredentialsProvider,
	#category : #'AWS-Core-Auth'
}

{ #category : #api }
AWSEnvironmentCredentialsProvider class >> getCredentials [
	"Try to get AWS Credentials from OS environment variables. Answer nil if these
	variables are not defined."

	| env accessKeyId secretKey sessionToken |
	env := OSEnvironment current.
	accessKeyId := env at: 'AWS_ACCESS_KEY_ID'
		ifAbsent: [ env at: 'AWS_ACCESS_KEY' ifAbsent: [ nil ]].
	secretKey := env at: 'AWS_SECRET_KEY' ifAbsent: [ nil ].
	(accessKeyId isEmptyOrNil or: [ secretKey isEmptyOrNil ])
		ifTrue: [ ^ nil ].
	sessionToken := env at: 'AWS_SESSION_TOKEN' ifAbsent: [ nil ].
	^ AWSCredentials
		accessKeyId: accessKeyId
		secretKey: secretKey
		sessionToken: sessionToken
]
