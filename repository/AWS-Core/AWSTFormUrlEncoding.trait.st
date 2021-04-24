Trait {
	#name : #AWSTFormUrlEncoding,
	#category : #'AWS-Core'
}

{ #category : #internal }
AWSTFormUrlEncoding classSide >> convertEntity: aFormUrlEncodedEntity [
	"Workaround for issue: https://github.com/svenvc/zinc/issues/50"

	| bytes |
	bytes := (String
		streamContents: [ :s | aFormUrlEncodedEntity writeOn: s ])
		utf8Encoded.
	^ (ZnByteArrayEntity type: ZnMimeType applicationFormUrlEncoded)
		bytes: bytes;
		contentLength: bytes size;
		yourself
]

{ #category : #internal }
AWSTFormUrlEncoding >> convertEntity: aFormUrlEncodedEntity [
	^ self class convertEntity: aFormUrlEncodedEntity
]
