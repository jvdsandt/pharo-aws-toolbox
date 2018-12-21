Class {
	#name : #AWSS3BucketInfo,
	#superclass : #AWSXmlObject,
	#instVars : [
		'name',
		'creationDate'
	],
	#category : #'AWS-SimpleStorageService'
}

{ #category : #accessing }
AWSS3BucketInfo >> creationDate [
	^ creationDate
]

{ #category : #initialization }
AWSS3BucketInfo >> initFromXmlElement: xmlElement [

	name := xmlElement contentStringAt: 'Name'.
	creationDate := DateAndTime fromString: (xmlElement contentStringAt: 'CreationDate')
]

{ #category : #accessing }
AWSS3BucketInfo >> name [
	^ name
]

{ #category : #printing }
AWSS3BucketInfo >> printOn: stream [
	super printOn: stream.
	stream nextPut: $(; print: self name; nextPut: $)
]
