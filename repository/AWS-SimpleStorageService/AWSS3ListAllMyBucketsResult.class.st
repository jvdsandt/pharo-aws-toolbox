Class {
	#name : #AWSS3ListAllMyBucketsResult,
	#superclass : #AWSXmlObject,
	#instVars : [
		'owner',
		'buckets'
	],
	#category : #'AWS-SimpleStorageService'
}

{ #category : #accessing }
AWSS3ListAllMyBucketsResult >> buckets [
	^ buckets
]

{ #category : #initialization }
AWSS3ListAllMyBucketsResult >> initFromXmlElement: xmlElement [

	buckets := (xmlElement elementAt: 'Buckets') elements asArray
		collect: [ :each | AWSS3BucketInfo new initFromXmlElement: each ]
]

{ #category : #accessing }
AWSS3ListAllMyBucketsResult >> owner [
	^ owner
]
