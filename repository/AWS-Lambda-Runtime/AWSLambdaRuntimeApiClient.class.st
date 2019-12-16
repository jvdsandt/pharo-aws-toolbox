Class {
	#name : #AWSLambdaRuntimeApiClient,
	#superclass : #Object,
	#instVars : [
		'httpClient',
		'baseUrl'
	],
	#category : #'AWS-Lambda-Runtime'
}

{ #category : #accessing }
AWSLambdaRuntimeApiClient >> createHttpClient [

	^ ZnClient new
		loggingOff;
		systemPolicy;
		accept: ZnMimeType applicationJson;
		enforceHttpSuccess: true;
		yourself
]

{ #category : #api }
AWSLambdaRuntimeApiClient >> getNext [

	^ self httpClient 
		url: 'http://', baseUrl, '/2018-06-01/runtime/invocation/next';
		get;
		response
]

{ #category : #accessing }
AWSLambdaRuntimeApiClient >> httpClient [

	^ httpClient ifNil: [ httpClient := self createHttpClient ]
]

{ #category : #api }
AWSLambdaRuntimeApiClient >> postInitializationError: anEntity [

	^ self httpClient 
		url: 'http://', baseUrl, '/2018-06-01/runtime/init/error';
		entity: anEntity;
		post
]

{ #category : #api }
AWSLambdaRuntimeApiClient >> postInvocationError: anEntity requestId: aRequestId [

	^ self httpClient 
		url: 'http://', baseUrl, '/2018-06-01/runtime/invocation/', aRequestId, '/error';
		entity: anEntity;
		post
]

{ #category : #api }
AWSLambdaRuntimeApiClient >> postInvocationResponse: anEntity requestId: aRequestId [

	^ self httpClient 
		url: 'http://', baseUrl, '/2018-06-01/runtime/invocation/', aRequestId, '/response';
		entity: anEntity;
		post
]

{ #category : #initialization }
AWSLambdaRuntimeApiClient >> setBaseUrl: anUrl [

	baseUrl := anUrl 
]
