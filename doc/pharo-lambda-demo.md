## Pharo Lambda Demo

The demo functions are implemented by the class **AWSLambdaAPIGatewayDemoHandler**. 
Currently three functions are implemented that simply return some information about the Smalltalk
image. 

##### Function 1: Return some info about a specific class
```smalltalk
showClassInfo: apiRequest

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
```

The dictionary returned will be converted into JSON. To test the error handling of the Pharo Lambda Runtime
you can ask for info about the Error class. This will trigger a MessageNotUnderstood error.

#### Function 2: Return a list of methods for a specific class
```smalltalk
showMethodNames: apiRequest

	| class meta |
	
	class := self getClassnameFrom: apiRequest
			ifAbsent: [ ^ self handleNotFound: 'Class not found' ].
			
	meta := (apiRequest queryStringParameterAt: 'meta' ifAbsent: [ 'false' ]) = 'true'.
	^ meta 
		ifTrue: [ class class methodDict keys sorted ]
		ifFalse: [ class methodDict keys sorted ]
```

#### Function 3: An about function which provides info about the runtime environment
```smalltalk
showAbout: apiRequest
			
	^ SmallDictionary new
			at: #description put: 'About ', self class name;
			at: #image put: SystemVersion current imageVersionString;
			at: #systemInfo put: self systemInfoDictionary;
			yourself
```