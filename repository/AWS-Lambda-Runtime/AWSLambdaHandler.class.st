Class {
	#name : #AWSLambdaHandler,
	#superclass : #Object,
	#instVars : [
		'context'
	],
	#category : #'AWS-Lambda-Runtime'
}

{ #category : #invoking }
AWSLambdaHandler >> cleanupAfterRequest [
	"Default: do nothing"
]

{ #category : #accessing }
AWSLambdaHandler >> context [
	^ context
]

{ #category : #accessing }
AWSLambdaHandler >> environment [
	^ self context environment 
]

{ #category : #invoking }
AWSLambdaHandler >> handleRequest: eventData [

	self logStream addEventMessage: 'Received: ', eventData printString.
	^self systemInfoDictionary
]

{ #category : #initialization }
AWSLambdaHandler >> initialiWithEnvironment: lambdaEnvironment [
	"Called once durint the initialization fase"

]

{ #category : #accessing }
AWSLambdaHandler >> logStream [
	^ self context logStream
]

{ #category : #initialization }
AWSLambdaHandler >> setContext: aLambdaContext [
	"Called before each invocation"

	context := aLambdaContext
]

{ #category : #invoking }
AWSLambdaHandler >> systemInfoDictionary [	

	^OrderedDictionary new
		at: 'timestamp' put: DateAndTime now asString;
		at: 'handlerClass' put: self class name;
		at: 'environment' put: self environment asDictionary;
		at: 'context' put: self context asDictionary;
		at: 'vmstats' put: SmalltalkImage current vm statisticsReport;
		yourself
]
