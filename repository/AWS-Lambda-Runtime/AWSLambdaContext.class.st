Class {
	#name : #AWSLambdaContext,
	#superclass : #Object,
	#instVars : [
		'environment',
		'headers',
		'logStream'
	],
	#category : #'AWS-Lambda-Runtime'
}

{ #category : #accessing }
AWSLambdaContext >> asDictionary [

	^ OrderedDictionary new
		at: 'requestId' put: self requestId;
		at: 'invokedFunctionArn' put: self invokedFunctionArn;
		at: 'deadlineMs' put: self deadlineMs;
		at: 'traceId' put: self traceId;
		yourself
		
]

{ #category : #accessing }
AWSLambdaContext >> clientContext [
	^ headers at: 'Lambda-Runtime-Client-Context' ifAbsent: [ nil ]
]

{ #category : #accessing }
AWSLambdaContext >> cognitoIdentity [
	^ headers at: 'Lambda-Runtime-Cognito-Identity' ifAbsent: [ nil ]
]

{ #category : #accessing }
AWSLambdaContext >> deadlineMs [
	"The date that the function times out in Unix time milliseconds"
	^ (headers at: 'Lambda-Runtime-Deadline-Ms') asInteger
]

{ #category : #accessing }
AWSLambdaContext >> environment [
	^ environment
]

{ #category : #accessing }
AWSLambdaContext >> invokedFunctionArn [
	^ headers at: 'Lambda-Runtime-Invoked-Function-Arn'
]

{ #category : #accessing }
AWSLambdaContext >> logStream [ 
	^ logStream
]

{ #category : #accessing }
AWSLambdaContext >> requestId [
	^ headers at: 'Lambda-Runtime-Aws-Request-Id'
]

{ #category : #initialization }
AWSLambdaContext >> setEnvironment: aLambdaEnvironment [

	environment := aLambdaEnvironment.
]

{ #category : #initialization }
AWSLambdaContext >> setHeaders: aZnHeaders [

	headers := aZnHeaders
]

{ #category : #initialization }
AWSLambdaContext >> setLogStream: aLogStream [

	logStream := aLogStream
]

{ #category : #accessing }
AWSLambdaContext >> traceId [
	^ headers at: 'Lambda-Runtime-Trace-Id'
]
