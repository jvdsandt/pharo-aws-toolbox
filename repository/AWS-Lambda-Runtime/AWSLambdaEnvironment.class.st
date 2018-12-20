Class {
	#name : #AWSLambdaEnvironment,
	#superclass : #Object,
	#instVars : [
		'startedAt',
		'handler',
		'region',
		'lambdaFunctionName',
		'lambdaFunctionMemorySize',
		'lambdaFunctionVersion',
		'lambdaRuntimeApi',
		'invocationCount',
		'invocationErrorCount',
		'secretAccessKey',
		'sessionToken',
		'accessKeyId',
		'lambdaLogGroupName',
		'lambdaLogStreamName'
	],
	#category : #'AWS-Lambda-Runtime'
}

{ #category : #accessing }
AWSLambdaEnvironment >> accessKeyId [
	^ accessKeyId ifNil: [ accessKeyId := self getEnv: 'AWS_ACCESS_KEY_ID' ]
]

{ #category : #accessing }
AWSLambdaEnvironment >> allOSEnvironmentVariables [

	| secretVars |
	
	secretVars := #( 'AWS_SECRET_ACCESS_KEY' 'AWS_SESSION_TOKEN' ).

	^ OSEnvironment current keys
			inject: Dictionary new
			into: [ :dict :each |
				dict 
					at: each put: ((secretVars includes: each) 
						ifTrue: [ '******' ]
						ifFalse: [OSEnvironment current getEnv: each ]);
					yourself ]
]

{ #category : #converting }
AWSLambdaEnvironment >> asDictionary [

	^ OrderedDictionary new
		at: 'variables' put: self allOSEnvironmentVariables;
		at: 'startedAt' put: self startedAt asString;
		at: 'invocationCount' put: self invocationCount;
		at: 'invocationErrorCount' put: self invocationErrorCount;
		at: 'startup' put: 0;
		yourself
]

{ #category : #accessing }
AWSLambdaEnvironment >> awsCredentials [ 

	^ AWSCredentials accessKeyId: self accessKeyId 
			secretKey: self secretAccessKey
			sessionToken: self sessionToken
]

{ #category : #accessing }
AWSLambdaEnvironment >> getEnv: varName [

	^ OSEnvironment current getEnv: varName
]

{ #category : #accessing }
AWSLambdaEnvironment >> handler [
	^ handler ifNil: [ handler := self getEnv: '_HANDLER' ]
]

{ #category : #internal }
AWSLambdaEnvironment >> incInvocationCount [
	invocationCount := invocationCount + 1
]

{ #category : #internal }
AWSLambdaEnvironment >> incInvocationErrorCount [
	invocationErrorCount := invocationErrorCount + 1
]

{ #category : #initialization }
AWSLambdaEnvironment >> initialize [

	super initialize.
	startedAt := DateAndTime now.
	invocationCount := 0.
	invocationErrorCount := 0.
]

{ #category : #accessing }
AWSLambdaEnvironment >> invocationCount [
	^ invocationCount
]

{ #category : #accessing }
AWSLambdaEnvironment >> invocationErrorCount [
	^ invocationErrorCount
]

{ #category : #accessing }
AWSLambdaEnvironment >> lambdaFunctionMemorySize [
	^ lambdaFunctionMemorySize ifNil: [ lambdaFunctionMemorySize := self getEnv: 'AWS_LAMBDA_FUNCTION_MEMORY_SIZE' ]
]

{ #category : #accessing }
AWSLambdaEnvironment >> lambdaFunctionName [
	^ lambdaFunctionName ifNil: [ lambdaFunctionName := self getEnv: 'AWS_LAMBDA_FUNCTION_NAME' ]
]

{ #category : #accessing }
AWSLambdaEnvironment >> lambdaFunctionVersion [
	^ lambdaFunctionVersion ifNil: [ lambdaFunctionVersion := self getEnv: 'AWS_LAMBDA_FUNCTION_VERSION' ]
]

{ #category : #accessing }
AWSLambdaEnvironment >> lambdaLogGroupName [

	^ lambdaLogGroupName ifNil: [ lambdaLogGroupName := self getEnv: 'AWS_LAMBDA_LOG_GROUP_NAME' ]
]

{ #category : #accessing }
AWSLambdaEnvironment >> lambdaLogStreamName [

	^ lambdaLogStreamName ifNil: [ lambdaLogStreamName := self getEnv: 'AWS_LAMBDA_LOG_STREAM_NAME' ]
]

{ #category : #accessing }
AWSLambdaEnvironment >> lambdaRuntimeApi [
	^ lambdaRuntimeApi ifNil: [ lambdaRuntimeApi := self getEnv: 'AWS_LAMBDA_RUNTIME_API' ]
]

{ #category : #accessing }
AWSLambdaEnvironment >> region [
	^ region ifNil: [ region := self getEnv: 'AWS_REGION' ]
]

{ #category : #accessing }
AWSLambdaEnvironment >> secretAccessKey [
	^ secretAccessKey ifNil: [ secretAccessKey := self getEnv: 'AWS_SECRET_ACCESS_KEY' ]
]

{ #category : #accessing }
AWSLambdaEnvironment >> sessionToken [
	^ sessionToken ifNil: [ sessionToken := self getEnv: 'AWS_SESSION_TOKEN' ]
]

{ #category : #accessing }
AWSLambdaEnvironment >> startedAt [
	^ startedAt
]
