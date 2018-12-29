Class {
	#name : #AWSS3ServiceTest,
	#superclass : #TestCase,
	#classVars : [
		'Credentials',
		'RegionName',
		'TestBucketName'
	],
	#category : #'AWS-SimpleStorageService-Tests'
}

{ #category : #accessing }
AWSS3ServiceTest class >> credentials [

	^ Credentials ifNil: [ AWSEnvironment defaultCredentials ]
]

{ #category : #accessing }
AWSS3ServiceTest class >> credentials: awsCredentials [

	Credentials := awsCredentials
]

{ #category : #accessing }
AWSS3ServiceTest class >> regionName [

	^ RegionName ifNil: [ AWSEnvironment defaultRegionName ]
]

{ #category : #accessing }
AWSS3ServiceTest class >> regionName: aString [

	RegionName := aString
]

{ #category : #accessing }
AWSS3ServiceTest class >> testBucketName [

	^ TestBucketName ifNil: [ TestBucketName := 'pharo-aws-toolbox' ]
]

{ #category : #accessing }
AWSS3ServiceTest class >> testBucketName: aString [

	TestBucketName := aString
]

{ #category : #accessing }
AWSS3ServiceTest >> s3service [

	^ AWSSimpleStorageService newWithCredentials: self class credentials region: self class regionName
]

{ #category : #accessing }
AWSS3ServiceTest >> s3testBucket [

	| s3s |
	
	s3s := self s3service.
	(s3s hasBucket: self class testBucketName)
		ifFalse: [ s3s put: self class testBucketName ].
		
	^ AWSS3Bucket newWithCredentials: self class credentials
			region: self class regionName
			bucket: self class testBucketName 
]

{ #category : #running }
AWSS3ServiceTest >> setUp [

	super setUp.
	(Credentials isNil and: [ AWSEnvironment hasDefaultCredentials not ])
		ifTrue: [ self skip: 'No AWS Credentials set' ]
]

{ #category : #tests }
AWSS3ServiceTest >> testBucketSetup [

	| s3b result |
	
	s3b := self s3testBucket.
	result := s3b listObjects.
	self assert: result class name equals: #AWSS3ListBucketsResult.
]

{ #category : #tests }
AWSS3ServiceTest >> testGetBuckets [

	| result |
	
	result := self s3service getBuckets.
	self assert: result class name equals: #AWSS3ListAllMyBucketsResult. 
]

{ #category : #tests }
AWSS3ServiceTest >> testPutObject [

	| s3b bytes entity result |
	
	s3b := self s3testBucket.
	
	bytes := ByteArray streamContents: [ :s |
		1 to: 10240 do: [ :index |
			s nextPut: index \\ 256 ] ].
	
	entity := ZnByteArrayEntity bytes: bytes.
			
	result := s3b put: entity key: 'testobject.bin' headers: { 
		'X-Pharo-H1' -> 'abc'.
		'X-Pharo-H2' -> 'qwerty'	
	 } asDictionary.
]
