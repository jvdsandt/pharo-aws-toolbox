Class {
	#name : #AWSS3ObjectInfo,
	#superclass : #AWSXmlObject,
	#instVars : [
		'key',
		'lastModified',
		'eTag',
		'size',
		'storageClass'
	],
	#category : #'AWS-SimpleStorageService'
}

{ #category : #accessing }
AWSS3ObjectInfo >> eTag [
	^ eTag
]

{ #category : #initialization }
AWSS3ObjectInfo >> initFromXmlElement: xmlElement [

	key := xmlElement contentStringAt: 'Key'.
	lastModified := DateAndTime fromString: (xmlElement contentStringAt: 'LastModified').
	eTag := xmlElement contentStringAt: 'ETag'.
	size := (xmlElement contentStringAt: 'Size') asInteger.
	storageClass := (xmlElement contentStringAt: 'StorageClass') asSymbol
]

{ #category : #accessing }
AWSS3ObjectInfo >> key [
	^ key
]

{ #category : #accessing }
AWSS3ObjectInfo >> lastModified [
	^ lastModified
]

{ #category : #printing }
AWSS3ObjectInfo >> printOn: stream [
	super printOn: stream.
	stream nextPut: $(; print: self key; nextPut: $)
]

{ #category : #accessing }
AWSS3ObjectInfo >> size [
	^ size
]

{ #category : #accessing }
AWSS3ObjectInfo >> storageClass [
	^ storageClass
]
