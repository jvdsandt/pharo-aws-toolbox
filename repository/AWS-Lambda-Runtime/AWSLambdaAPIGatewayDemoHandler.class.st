Class {
	#name : #AWSLambdaAPIGatewayDemoHandler,
	#superclass : #AWSLambdaAPIGatewayHandler,
	#category : #'AWS-Lambda-Runtime-API-Gateway'
}

{ #category : #invoking }
AWSLambdaAPIGatewayDemoHandler >> getClassnameFrom: apiRequest ifAbsent: aBlock [
	"Format: /classes/{className}"
	
	| name |
	
	name := (apiRequest pathParameterAt: 'className' ifAbsent: [ ^ aBlock value ]) asSymbol.
	^ Smalltalk globals at: name ifAbsent: aBlock
]

{ #category : #invoking }
AWSLambdaAPIGatewayDemoHandler >> handleAPIRequest: apiRequest [

	apiRequest resource = '/classes/{className}/methods'
		ifTrue: [ ^ self showMethodNames: apiRequest ].
		
	apiRequest resource = '/classes/{className}'
		ifTrue: [ ^ self showClassInfo: apiRequest ].
		
	apiRequest resource = '/about'
		ifTrue: [ ^ self showAbout: apiRequest ].
		
	^ self handleNotFound: 'Unknown resource'
]

{ #category : #invoking }
AWSLambdaAPIGatewayDemoHandler >> handleNotFound: aMessage [

	^ AWSLambdaAPIProxyResponse new
			statusCode: 404;
			bodyJson: (SmallDictionary new
				at: #code put: 404;
				at: #message put: aMessage;
				yourself);
			yourself
]

{ #category : #operations }
AWSLambdaAPIGatewayDemoHandler >> showAbout: apiRequest [
			
	^ OrderedDictionary new
			at: 'description' put: 'About ', self class name;
			at: 'image' put: SystemVersion current imageVersionString;
			at: 'systemInfo' put: self systemInfoDictionary;
			yourself
]

{ #category : #operations }
AWSLambdaAPIGatewayDemoHandler >> showClassInfo: apiRequest [

	| class |
	
	class := self getClassnameFrom: apiRequest
			ifAbsent: [ ^ self handleNotFound: 'Class not found' ].

	"Force an error so we can test the error handling"
	class name = #Error
		ifTrue: [ nil doYouUnderstandThisMessage ].
			
	^ SmallDictionary new
			at: #name put: class name;
			at: #superclass put: class superclass name;
			yourself
]

{ #category : #operations }
AWSLambdaAPIGatewayDemoHandler >> showMethodNames: apiRequest [

	| class meta |
	
	class := self getClassnameFrom: apiRequest
			ifAbsent: [ ^ self handleNotFound: 'Class not found' ].
			
	meta := (apiRequest queryStringParameterAt: 'meta' ifAbsent: [ 'false' ]) = 'true'.
	^ meta 
		ifTrue: [ class class methodDict keys sorted ]
		ifFalse: [ class methodDict keys sorted ]
	
	
]
