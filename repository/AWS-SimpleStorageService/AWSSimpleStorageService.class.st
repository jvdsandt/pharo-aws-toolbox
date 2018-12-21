Class {
	#name : #AWSSimpleStorageService,
	#superclass : #AWSS3Service,
	#category : #'AWS-SimpleStorageService'
}

{ #category : #'as yet unclassified' }
AWSSimpleStorageService >> getBuckets [

	| httpRequest response |

	httpRequest := ZnRequest get: self endpoint.
	self signRequest: httpRequest.
	
	response := self httpClient 
		request: httpRequest;
		execute;
		response.
		
	response isSuccess 
		ifFalse: [ self handleErrorResponse: response ].
		
	^ AWSS3ListAllMyBucketsResult fromXmlString: response contents

]

{ #category : #initialization }
AWSSimpleStorageService >> initWithCredentials: aCredentials region: aRegion [

	super initWithCredentials: aCredentials region: aRegion.
	endpoint := 'https://s3-', region asLowercase, '.amazonaws.com'.
]
