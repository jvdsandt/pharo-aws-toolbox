Class {
	#name : #AWSLambdaCommandLineHandler,
	#superclass : #CommandLineHandler,
	#instVars : [
		'lambdaEnvironment',
		'runtimeApiClient',
		'logStream',
		'handler'
	],
	#category : #'AWS-Lambda-Runtime'
}

{ #category : #accessing }
AWSLambdaCommandLineHandler class >> commandName [
	^ 'aws-lambda'
]

{ #category : #accessing }
AWSLambdaCommandLineHandler class >> description [
	^ 'AWS Lambda Pharo Smalltalk Runtime'
]

{ #category : #activation }
AWSLambdaCommandLineHandler >> activate [

	self stdout nextPutAll: self startupMessage; lf.

	[ self doInitializationTasks ] on: Error do: [ :ex | self handleInitializationError: ex ].

	self doProcessingTasks.
	
	self quit
]

{ #category : #internal }
AWSLambdaCommandLineHandler >> createContext: aZnResponse [

	^ AWSLambdaContext new
			setEnvironment: lambdaEnvironment;
			setLogStream: logStream;
			setHeaders: aZnResponse headers;
			yourself
]

{ #category : #internal }
AWSLambdaCommandLineHandler >> doInitializationTasks [

	| handlerName handlerClass |
	
	self lambdaEnvironment lambdaRuntimeApi isEmptyOrNil 
		ifTrue: [ self exitFailure: 'AWS_LAMBDA_RUNTIME_API environment variable not set' ].

	runtimeApiClient := AWSLambdaRuntimeApiClient new
		setBaseUrl: self lambdaEnvironment lambdaRuntimeApi;
		yourself.
		
	self initLogStream.
	logStream addEventMessage: self startupMessage.

	handlerName := self lambdaEnvironment handler.
	handlerName isEmptyOrNil 
		ifTrue: [ self error: 'No handler present' ].
		
	handlerClass := Smalltalk globals at: handlerName asSymbol ifAbsent: [ nil ].
	handlerClass isClass
		ifFalse: [ self error: 'Handler class ', handlerName printString, ' not found' ].
		
	handler := handlerClass new.
	
	logStream
		addEventMessage: 'Handler ', handlerClass name, ' ready!';
		flush.
		
	self logStdout: [ :s | s nextPutAll: 'Initialization finished.' ]
]

{ #category : #internal }
AWSLambdaCommandLineHandler >> doProcessingTask [

	| nextResponse context |
	
	nextResponse := runtimeApiClient getNext.
	
	"Propagate the tracing header"
	nextResponse headers at: 'Lambda-Runtime-Trace-Id'
		ifPresent: [ :v | OSEnvironment current at: '_X_AMZN_TRACE_ID' put: v ].

	lambdaEnvironment incInvocationCount.
	handler setContext: (context := self createContext: nextResponse).

	[ 
		| result resultEntity |
		result := handler handleRequest: nextResponse contents.
		result isString
			ifFalse: [ result := self jsonWriter toString: result ].
		self logStream flush.
		resultEntity := (ZnStringEntity type: self responseMimeType)
			string: result;
			yourself.
		runtimeApiClient postInvocationResponse: resultEntity requestId: context requestId.
		self logStdout: [ :s | s nextPutAll: 'Task completed.' ].
	] on: Error do: [ :ex |
		self logStdout: [ :s | 
			s 
				nextPutAll: 'Task error: ';
				nextPutAll: ex class name; nextPutAll: ' - ';
				nextPutAll: ex messageText; lf.
			self printStacktraceFor: ex on: s ].
		self handleInvocationError: ex data: nextResponse contents context: context.
		ex return ].

	handler cleanupAfterRequest
]

{ #category : #internal }
AWSLambdaCommandLineHandler >> doProcessingTasks [

	[ self doProcessingTask. true ] whileTrue
]

{ #category : #internal }
AWSLambdaCommandLineHandler >> handleInitializationError: anException [

	| result resultEntity |
	
	result := AWSLambdaError type: anException class name message: anException description.
	resultEntity := (ZnStringEntity type: self responseMimeType)
		string: result asJsonString;
		yourself.
		
	runtimeApiClient postInitializationError: resultEntity.

	self exitFailure: anException description
]

{ #category : #internal }
AWSLambdaCommandLineHandler >> handleInvocationError: error data: data context: aContext [

	| result resultEntity |

	lambdaEnvironment incInvocationErrorCount.
	result := AWSLambdaError type: error class name message: error description.
	resultEntity := (ZnStringEntity type: self responseMimeType)
		string: result asJsonString;
		yourself.

	[ self logStream addEventMessage: (String streamContents: [ :s |
		s
			nextPutAll: 'Error: '; nextPutAll: error description asString; lf;
			nextPutAll: 'Request: '; nextPutAll: data asString; lf; lf.
		self printStacktraceFor: error on: s ]).
		self logStream flush ] on: Error do: [ :ex | ex return ].
			
	runtimeApiClient postInvocationError: resultEntity requestId: aContext requestId
]

{ #category : #internal }
AWSLambdaCommandLineHandler >> initLogStream [

	| logService |
	
	logService := AWSLogs newWithCredentials: self lambdaEnvironment awsCredentials 
			region: self lambdaEnvironment region.
			
	[ logStream := logService getStream: self lambdaEnvironment lambdaLogStreamName 
			group: self lambdaEnvironment lambdaLogGroupName 
	] on: Error do: [ :ex |
		| errorMsg |
		errorMsg := 'Failed to setup logStream: ', ex messageText printString.
		self stderr cr; nextPutAll: errorMsg.
		self exitFailure: errorMsg ].
]

{ #category : #initialization }
AWSLambdaCommandLineHandler >> initialize [

	super initialize.
	lambdaEnvironment := AWSLambdaEnvironment new
]

{ #category : #resources }
AWSLambdaCommandLineHandler >> jsonReader [

	^ NeoJSONReader
]

{ #category : #resources }
AWSLambdaCommandLineHandler >> jsonWriter [

	^ NeoJSONWriter
]

{ #category : #accessing }
AWSLambdaCommandLineHandler >> lambdaEnvironment [
	^ lambdaEnvironment
]

{ #category : #internal }
AWSLambdaCommandLineHandler >> logStdout: aBlock [

	self stdout nextPutAll: (
		String streamContents: [ :s |
			aBlock value: s.
			s lf ])
]

{ #category : #accessing }
AWSLambdaCommandLineHandler >> logStream [

	^ logStream
]

{ #category : #internal }
AWSLambdaCommandLineHandler >> printStacktraceFor: err on: stream [

	| context |

	context := err signalerContext.
	[ context isNil or: [ context methodSelector == #doProcessingTask ] ] whileFalse: [
		stream print: context; lf.
		context := context sender ]
]

{ #category : #resources }
AWSLambdaCommandLineHandler >> responseMimeType [

	^ ZnMimeType applicationJson setCharSetUTF8
]

{ #category : #resources }
AWSLambdaCommandLineHandler >> startupMessage [

	^ self class name, ' - ', SystemVersion current imageVersionString
]
