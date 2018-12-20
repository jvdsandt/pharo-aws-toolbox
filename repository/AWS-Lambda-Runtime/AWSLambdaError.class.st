Class {
	#name : #AWSLambdaError,
	#superclass : #AWSJsonObject,
	#instVars : [
		'errorType',
		'errorMessage'
	],
	#category : #'AWS-Lambda-Runtime'
}

{ #category : #'instance creation' }
AWSLambdaError class >> type: typeString message: msgString [

	^ self new
			errorType: typeString;
			errorMessage: msgString;
			yourself
]

{ #category : #accessing }
AWSLambdaError >> errorMessage [
	^ errorMessage
]

{ #category : #accessing }
AWSLambdaError >> errorMessage: anObject [
	errorMessage := anObject
]

{ #category : #accessing }
AWSLambdaError >> errorType [
	^ errorType
]

{ #category : #accessing }
AWSLambdaError >> errorType: anObject [
	errorType := anObject
]
