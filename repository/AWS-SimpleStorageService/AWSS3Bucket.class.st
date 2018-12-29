Class {
	#name : #AWSS3Bucket,
	#superclass : #AWSS3Service,
	#category : #'AWS-SimpleStorageService'
}

{ #category : #'instance creation' }
AWSS3Bucket class >> newWithBucket: bucketName [

	^ self newWithCredentials: AWSEnvironment defaultCredentials 
			region: AWSEnvironment defaultRegionName
			bucket: bucketName
]

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
	response := self executeRequest: httpRequest.
	
	^ response
]

{ #category : #operations }
AWSS3Bucket >> head: aKey [

	| url httpRequest response |
	
	url := self endpoint asZnUrl / aKey.
	httpRequest := ZnRequest head: url.
	response := self executeRequest: httpRequest.
		
	^ response
]

{ #category : #initialization }
AWSS3Bucket >> initWithCredentials: aCredentials region: aRegion bucket: bucketName [

	self initWithCredentials: aCredentials 
		region: aRegion
		endpoint: 'https://s3-', aRegion asLowercase, '.amazonaws.com/', bucketName
]

{ #category : #initialization }
AWSS3Bucket >> initWithCredentials: aCredentials region: aRegion endpoint: hostname [

	self initWithCredentials: aCredentials region: aRegion.
	endpoint := hostname
]

{ #category : #operations }
AWSS3Bucket >> listObjects [

	| url httpRequest response |
	
	url := self endpoint asZnUrl.
	url queryAt: 'list-type' put: 2.

	httpRequest := ZnRequest get: url.
	response := self executeRequest: httpRequest.
		
	^ AWSS3ListBucketsResult fromXmlString: response contents

]

{ #category : #operations }
AWSS3Bucket >> put: anEntity key: aKey [

	^ self put: anEntity key: aKey headers: nil
]

{ #category : #operations }
AWSS3Bucket >> put: anEntity key: aKey headers: aHeaders [

	| url httpRequest response md5hash eTag |
	
	url := self endpoint asZnUrl / aKey.
	md5hash := MD5 new hashMessage: anEntity asByteArray. 

	httpRequest := ZnRequest put: url.
	httpRequest entity: anEntity.
	aHeaders notNil
		ifTrue: [ httpRequest headers addAll: aHeaders ].
	httpRequest headers at: 'Content-MD5' put: (ZnUtils encodeBase64: md5hash).
	response := self executeRequest: httpRequest.
		
	eTag := response headers at: 'ETag'.
	(md5hash hex match: eTag withoutQuoting)
		ifFalse: [ AWSError signal: 'Data error - hash mismatch' ].
	
	^ response
]
