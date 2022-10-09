Class {
	#name : #AWSCredentialsProvider,
	#superclass : #Object,
	#category : #'AWS-Core-Auth'
}

{ #category : #api }
AWSCredentialsProvider class >> getCredentials [

	^self subclassResponsibility 
]

{ #category : #accessing }
AWSCredentialsProvider class >> getCredentialsIfAbsent: aBlock [

	^self getCredentials ifNil: [ aBlock value ]
]
