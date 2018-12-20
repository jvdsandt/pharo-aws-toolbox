"
I hold all response information for Lambda Functions used in the API Gateway Lambda Proxy Integration
"
Class {
	#name : #AWSLambdaAPIProxyResponse,
	#superclass : #AWSJsonObject,
	#instVars : [
		'isBase64Encoded',
		'statusCode',
		'headers',
		'multiValueHeaders',
		'body'
	],
	#category : #'AWS-Lambda-Runtime-API-Gateway'
}

{ #category : #accessing }
AWSLambdaAPIProxyResponse >> body [
	^ body
]

{ #category : #accessing }
AWSLambdaAPIProxyResponse >> body: anObject [
	body := anObject
]

{ #category : #convenience }
AWSLambdaAPIProxyResponse >> bodyJson: anObject [

	self body: (NeoJSONWriter toString: anObject).
	self isBase64Encoded: false.
	self headers at: 'Content-Type' put: ZnMimeType applicationJson asString
]

{ #category : #convenience }
AWSLambdaAPIProxyResponse >> enableCORS [

	self enableCORS: '*'
]

{ #category : #convenience }
AWSLambdaAPIProxyResponse >> enableCORS: aDomainName [

	self headers at: 'Access-Control-Allow-Origin' put: aDomainName
]

{ #category : #accessing }
AWSLambdaAPIProxyResponse >> headers [
	^ headers ifNil: [ headers := Dictionary new ]
]

{ #category : #accessing }
AWSLambdaAPIProxyResponse >> headers: anObject [
	headers := anObject
]

{ #category : #accessing }
AWSLambdaAPIProxyResponse >> isBase64Encoded [
	^ isBase64Encoded
]

{ #category : #accessing }
AWSLambdaAPIProxyResponse >> isBase64Encoded: anObject [
	isBase64Encoded := anObject
]

{ #category : #accessing }
AWSLambdaAPIProxyResponse >> multiValueHeaders [
	^ multiValueHeaders
]

{ #category : #accessing }
AWSLambdaAPIProxyResponse >> multiValueHeaders: anObject [
	multiValueHeaders := anObject
]

{ #category : #accessing }
AWSLambdaAPIProxyResponse >> statusCode [
	^ statusCode
]

{ #category : #accessing }
AWSLambdaAPIProxyResponse >> statusCode: anObject [
	statusCode := anObject
]
