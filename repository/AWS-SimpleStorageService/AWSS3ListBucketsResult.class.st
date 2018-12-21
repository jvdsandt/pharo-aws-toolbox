Class {
	#name : #AWSS3ListBucketsResult,
	#superclass : #AWSXmlObject,
	#instVars : [
		'name',
		'prefix',
		'keyCount',
		'maxKeys',
		'isTruncated',
		'objects'
	],
	#category : #'AWS-SimpleStorageService'
}

{ #category : #initialization }
AWSS3ListBucketsResult >> initFromXmlElement: xmlElement [

	name := xmlElement contentStringAt: 'Name'.
	prefix := xmlElement contentStringAt: 'Prefix'.
	keyCount := (xmlElement contentStringAt: 'KeyCount') asInteger.
	maxKeys := (xmlElement contentStringAt: 'MaxKeys') asInteger.
	isTruncated := (xmlElement contentStringAt: 'IsTruncated') = 'true'.
	
	objects := (xmlElement elementsAt: 'Contents') asArray 
			collect: [ :each | AWSS3ObjectInfo new initFromXmlElement: each ]
	

]

{ #category : #accessing }
AWSS3ListBucketsResult >> isTruncated [
	^ isTruncated
]

{ #category : #accessing }
AWSS3ListBucketsResult >> keyCount [
	^ keyCount
]

{ #category : #accessing }
AWSS3ListBucketsResult >> maxKeys [
	^ maxKeys
]

{ #category : #accessing }
AWSS3ListBucketsResult >> name [
	^ name
]

{ #category : #accessing }
AWSS3ListBucketsResult >> objects [
	^ objects
]

{ #category : #accessing }
AWSS3ListBucketsResult >> prefix [
	^ prefix
]
