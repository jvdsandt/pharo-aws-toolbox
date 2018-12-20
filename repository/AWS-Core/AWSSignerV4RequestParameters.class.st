Class {
	#name : #AWSSignerV4RequestParameters,
	#superclass : #Object,
	#instVars : [
		'regionName',
		'serviceName',
		'signingDateTime',
		'formattedSigningDateTime',
		'formattedSigningDate',
		'signingAlgorithm'
	],
	#category : #'AWS-Core-Auth'
}

{ #category : #utilities }
AWSSignerV4RequestParameters class >> getRegionNameFromHost: aString [

	(aString endsWith: '.amazonaws.com')
		ifTrue: [ 
			| part index |
			part := aString copyFrom: 1 to: aString size - 14.
			index := part lastIndexOf: $..
			index > 0
				ifTrue: [ ^ (part allButFirst: index) asLowercase ] ].
			
	self error: 'Cannot get region name from host name'
	
	"self getRegionNameFromHost: 'logs.eu-west-1.amazonaws.com'"	
]

{ #category : #utilities }
AWSSignerV4RequestParameters class >> getServiceNameFromHost: aString [

	| index |
	
	index := aString indexOf: $..
	^ index > 1
			ifTrue: [ (aString copyFrom: 1 to: index-1) asLowercase ]
			ifFalse: [ self error: 'Cannot get service name from host name' ]

	"self getServiceNameFromHost: 'logs.eu-west-1.amazonaws.com'"	
]

{ #category : #accessing }
AWSSignerV4RequestParameters >> formattedSigningDate [
	^ formattedSigningDate
]

{ #category : #accessing }
AWSSignerV4RequestParameters >> formattedSigningDateTime [

	^ formattedSigningDateTime
]

{ #category : #internal }
AWSSignerV4RequestParameters >> generateScope [

	^ String streamContents: [ :s |
		s
			nextPutAll: self formattedSigningDate; nextPut: $/;
			nextPutAll: self regionName; nextPut: $/;
			nextPutAll: self serviceName; nextPut: $/;
			nextPutAll: 'aws4_request' ]
]

{ #category : #initialization }
AWSSignerV4RequestParameters >> initWithDatTime: aDateTime request: aRequest [

	self initWithDatTime: aDateTime 
			service: (self class getServiceNameFromHost: aRequest url host) 
			region: (self class getRegionNameFromHost: aRequest url host) 
]

{ #category : #initialization }
AWSSignerV4RequestParameters >> initWithDatTime: aDateTime service: aServiceName region: aRegionName [

	self setSigningDateTime: aDateTime.
	serviceName := aServiceName.
	regionName := aRegionName.
	signingAlgorithm := AWSSignerV4 signingAlgorithm.

]

{ #category : #initialization }
AWSSignerV4RequestParameters >> initWithRequest: aRequest [

	self initWithDatTime: DateAndTime now asUTC request: aRequest
]

{ #category : #accessing }
AWSSignerV4RequestParameters >> regionName [
	^ regionName
]

{ #category : #accessing }
AWSSignerV4RequestParameters >> scope [

	^ self generateScope
]

{ #category : #accessing }
AWSSignerV4RequestParameters >> serviceName [
	^ serviceName
]

{ #category : #initialization }
AWSSignerV4RequestParameters >> setSigningDateTime: aDateTime [

	signingDateTime := aDateTime.
	formattedSigningDate := signingDateTime asDate printFormat: #(3 2 1 0 1 1 2).
	formattedSigningDateTime := String streamContents: [ :s |
		s nextPutAll: formattedSigningDate; nextPut: $T.
		signingDateTime hours printOn: s base: 10 nDigits: 2.
		signingDateTime minutes printOn: s base: 10 nDigits: 2.
		signingDateTime seconds printOn: s base: 10 nDigits: 2.
		s nextPut: $Z ]

]

{ #category : #accessing }
AWSSignerV4RequestParameters >> signingAlgorithm [
	^ signingAlgorithm
]

{ #category : #accessing }
AWSSignerV4RequestParameters >> signingDateTime [

	^ signingDateTime ifNil: [ 
			self signingDateTime: DateAndTime now asUTC.
			signingDateTime ]
]
