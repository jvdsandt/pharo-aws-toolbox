Class {
	#name : #AWSUtils,
	#superclass : #Object,
	#category : #'AWS-Core'
}

{ #category : #utilities }
AWSUtils class >> awsJsonMimeType [

	^ ZnMimeType main: 'application' sub: 'x-amz-json-1.1'
]

{ #category : #utilities }
AWSUtils class >> awsTimestamp [
	"The number of milliseconds after Jan 1, 1970 00:00:00 UTC"

	^ (DateAndTime now asUTC - DateAndTime unixEpoch) asMilliSeconds
]
