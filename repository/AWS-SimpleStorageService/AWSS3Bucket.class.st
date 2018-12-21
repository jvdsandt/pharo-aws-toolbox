Class {
	#name : #AWSS3Bucket,
	#superclass : #AWSS3Service,
	#category : #'AWS-SimpleStorageService'
}

{ #category : #'instance creation' }
AWSS3Bucket class >> newWithCredentials: aCredentials region: aRegion bucket: bucketName [

	^ self basicNew initWithCredentials: aCredentials region: aRegion bucket: bucketName
]

{ #category : #'instance creation' }
AWSS3Bucket class >> newWithCredentials: aCredentials region: aRegion host: hostname [

	^ self basicNew initWithCredentials: aCredentials region: aRegion host: hostname
]

{ #category : #operations }
AWSS3Bucket >> get: aKey [

	| url httpRequest response |
	
	url := self endpoint asZnUrl / aKey.

	httpRequest := ZnRequest get: url.
	self signRequest: httpRequest.
	
	response := self httpClient 
		request: httpRequest;
		execute;
		response.
		
	response isSuccess 
		ifFalse: [ self handleErrorResponse: response ].
		
	^ response
]

{ #category : #operations }
AWSS3Bucket >> head: aKey [

	| url httpRequest response |
	
	url := self endpoint asZnUrl / aKey.

	httpRequest := ZnRequest head: url.
	self signRequest: httpRequest.
	
	response := self httpClient 
		request: httpRequest;
		execute;
		response.
		
	response isSuccess 
		ifFalse: [ self handleErrorResponse: response ].
		
	^ response
]

{ #category : #initialization }
AWSS3Bucket >> initWithCredentials: aCredentials region: aRegion bucket: bucketName [

	self initWithCredentials: aCredentials 
		region: aRegion
		host: 'https://', bucketName , '.s3-', aRegion asLowercase, '.amazonaws.com'
]

{ #category : #initialization }
AWSS3Bucket >> initWithCredentials: aCredentials region: aRegion host: hostname [

	self initWithCredentials: aCredentials region: aRegion.
	endpoint := hostname
]

{ #category : #operations }
AWSS3Bucket >> listObjects [

	| url httpRequest response |
	
	url := self endpoint asZnUrl.
	url queryAt: 'list-type' put: 2.

	httpRequest := ZnRequest get: url.
	self signRequest: httpRequest.
	
	response := self httpClient 
		request: httpRequest;
		execute;
		response.
		
	response isSuccess 
		ifFalse: [ self handleErrorResponse: response ].
		
	^ AWSS3ListBucketsResult fromXmlString: response contents

]

{ #category : #operations }
AWSS3Bucket >> put: anEntity key: aKey [

	| md5hash url httpRequest response |
	
	md5hash := MD5 new hashMessage: anEntity asByteArray. 
	
	url := self endpoint asZnUrl / aKey.

	httpRequest := ZnRequest put: url.
	httpRequest entity: anEntity.
	httpRequest headers at: 'Content-MD5' put: md5hash hex.
	self signRequest: httpRequest.
	
	response := self httpClient 
		request: httpRequest;
		execute;
		response.
		
	response isSuccess 
		ifFalse: [ self handleErrorResponse: response ].
		
	^ response
]
