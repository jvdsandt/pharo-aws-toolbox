Class {
	#name : #AWSLambdaAPIGatewayHandler,
	#superclass : #AWSLambdaHandler,
	#category : #'AWS-Lambda-Runtime-API-Gateway'
}

{ #category : #invoking }
AWSLambdaAPIGatewayHandler >> handleAPIRequest: apiRequest [
	"Default stub implementation. Subclasses should replace this with something usefull."

	^ AWSLambdaAPIProxyResponse new
			statusCode: 200;
			bodyJson: { 'Message' -> 'Not yet implemented' } asDictionary;
			enableCORS;
			yourself
]

{ #category : #invoking }
AWSLambdaAPIGatewayHandler >> handleRequest: eventData [
	"Create a API Gateway request from the eventData. Also make sure
	that we answer a API Gateway response object."

	| request response |
	
	self logRequest: eventData.
	request := AWSLambdaAPIProxyRequest fromJsonString: eventData.
	response := self handleAPIRequest: request.
	(response isKindOf: AWSLambdaAPIProxyResponse)
		ifFalse: [ 
			response := AWSLambdaAPIProxyResponse new
				statusCode: 200;
				bodyJson: response;
				yourself ].
	self logResponse: response.
	^ response
]

{ #category : #invoking }
AWSLambdaAPIGatewayHandler >> logRequest: eventData [

	self logStream addEventMessage: 'REQUEST: ', eventData
]

{ #category : #invoking }
AWSLambdaAPIGatewayHandler >> logResponse: apiProxyResponse [

	self logStream addEventMessage: 'RESPONSE: ', apiProxyResponse body asString
]
