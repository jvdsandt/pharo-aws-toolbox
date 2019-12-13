Class {
	#name : #AWSSQSRequest,
	#superclass : #Object,
	#category : #'AWS-SimpleQueueService'
}

{ #category : #internal }
AWSSQSRequest >> convertEntity: aFormUrlEncodedEntity [
	"https://github.com/svenvc/zinc/issues/50"
	
	^ (ZnByteArrayEntity type: ZnMimeType applicationFormUrlEncoded)
			bytes: (String streamContents: [ :s | aFormUrlEncodedEntity writeOn: s ]) utf8Encoded;
			yourself
]

{ #category : #adding }
AWSSQSRequest >> version [

	^ '2012-11-05'
]
