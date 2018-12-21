"
I am an abstract class with functionality to access AWS services. Use one of my subclasses to access a specific AWS service.
"
Class {
	#name : #AWSService,
	#superclass : #Object,
	#instVars : [
		'httpClient',
		'awsCredentials',
		'endpoint',
		'region'
	],
	#category : #'AWS-Core'
}

{ #category : #'instance creation' }
AWSService class >> new [

	^ self newWithCredentials: AWSCredentials default 
			region: (AWSSignerUtils getRegionNameFromProfile: 'default' ifAbsent: [ self error: 'AWS: No default region' ])
]

{ #category : #'instance creation' }
AWSService class >> newWithCredentials: aCredentials region: aRegion [

	^ self basicNew initWithCredentials: aCredentials region: aRegion
]

{ #category : #accessing }
AWSService >> awsCredentials [
	^ awsCredentials
]

{ #category : #accessing }
AWSService >> endpoint [
	^ endpoint
]

{ #category : #internal }
AWSService >> handleErrorResponse: httpResponse [

	| data |
	
	data := httpResponse contents.
	data notNil
		ifTrue: [ 
			data := NeoJSONReader fromString: data.
			(AWSError data: data) signal ].
		
	self error: 'Unknown AWS error'
]

{ #category : #accessing }
AWSService >> httpClient [

	^ httpClient ifNil: [ 
			httpClient := ZnClient new
				systemPolicy;
				enforceHttpSuccess: false;
				enforceAcceptContentType: false;
				yourself ]
]

{ #category : #initialization }
AWSService >> initWithCredentials: aCredentials region: aRegion [

	awsCredentials := aCredentials.
	region := aRegion.
]

{ #category : #accessing }
AWSService >> region [
	^ region
]

{ #category : #internal }
AWSService >> signRequest: httpRequest [

	awsCredentials sessionToken notNil
		ifTrue: [ httpRequest headers at: AWSHeaders x_amz_security_token put: awsCredentials sessionToken ].
	
	AWSSignerV4 new sign: httpRequest using: awsCredentials
]
