Class {
	#name : #AWSGenericResult,
	#superclass : #AWSLogsResult,
	#instVars : [
		'headers',
		'contents'
	],
	#category : #'AWS-CloudWatch-Logs-Results'
}

{ #category : #'instance creation' }
AWSGenericResult class >> fromJsonStream: aStream [

	^ self new
			setContents: (NeoJSONReader on: aStream) next;
			yourself
]

{ #category : #'instance creation' }
AWSGenericResult class >> fromJsonString: aString [

	^ aString isNil
			ifTrue: [ self new ]
			ifFalse: [ self fromJsonStream: aString readStream ]
]

{ #category : #initialization }
AWSGenericResult >> setContents: aDictionary [

	contents := aDictionary
]

{ #category : #initialization }
AWSGenericResult >> setHeaders: responseHeaders [

	headers := responseHeaders

]
