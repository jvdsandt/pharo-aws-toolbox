"
I hold all request information for Lambda Functions used in the API Gateway Lambda Proxy Integration
"
Class {
	#name : #AWSLambdaAPIProxyRequest,
	#superclass : #AWSJsonObject,
	#instVars : [
		'resource',
		'path',
		'httpMethod',
		'headers',
		'multiValueHeaders',
		'queryStringParameters',
		'multiValueQueryStringParameters',
		'pathParameters',
		'stageVariables',
		'requestContext',
		'body',
		'isBase64Encoded'
	],
	#category : #'AWS-Lambda-Runtime-API-Gateway'
}

{ #category : #accessing }
AWSLambdaAPIProxyRequest >> body [
	^ body
]

{ #category : #accessing }
AWSLambdaAPIProxyRequest >> bodyDecoded [
	^ self isBase64Encoded 
			ifTrue: [
				| bytes |
				bytes := ZnBase64Encoder new decode: self body.
				ZnUTF8Encoder new decodeBytes: bytes ]
			ifFalse: [ body ]
]

{ #category : #accessing }
AWSLambdaAPIProxyRequest >> headers [
	^ headers
]

{ #category : #accessing }
AWSLambdaAPIProxyRequest >> httpMethod [
	^ httpMethod
]

{ #category : #accessing }
AWSLambdaAPIProxyRequest >> isBase64Encoded [
	^ isBase64Encoded
]

{ #category : #accessing }
AWSLambdaAPIProxyRequest >> multiValueHeaders [
	^ multiValueHeaders
]

{ #category : #accessing }
AWSLambdaAPIProxyRequest >> multiValueQueryStringParameters [
	^ multiValueQueryStringParameters
]

{ #category : #accessing }
AWSLambdaAPIProxyRequest >> path [
	^ path
]

{ #category : #convenience }
AWSLambdaAPIProxyRequest >> pathParameterAt: aKey ifAbsent: aBlock [

	pathParameters isNil
		ifTrue: [ ^ aBlock value ].
		
	^ pathParameters at: aKey ifAbsent: aBlock
]

{ #category : #accessing }
AWSLambdaAPIProxyRequest >> pathParameters [
	^ pathParameters
]

{ #category : #convenience }
AWSLambdaAPIProxyRequest >> queryStringParameterAt: aKey ifAbsent: aBlock [

	queryStringParameters isNil
		ifTrue: [ ^ aBlock value ].
		
	^ queryStringParameters at: aKey ifAbsent: aBlock
]

{ #category : #accessing }
AWSLambdaAPIProxyRequest >> queryStringParameters [
	^ queryStringParameters
]

{ #category : #accessing }
AWSLambdaAPIProxyRequest >> requestContext [
	^ requestContext
]

{ #category : #accessing }
AWSLambdaAPIProxyRequest >> resource [
	^ resource
]

{ #category : #accessing }
AWSLambdaAPIProxyRequest >> stageVariables [
	^ stageVariables
]
