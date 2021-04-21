Trait {
	#name : #AWSTXmlErrorResponseHandler,
	#category : #'AWS-Core'
}

{ #category : #internal }
AWSTXmlErrorResponseHandler >> handleErrorResponse: httpResponse [
	| dom |
	(httpResponse hasEntity and: [ httpResponse contentType sub = 'xml' ])
		ifFalse: [ ^ super handleErrorResponse: httpResponse ].
	dom := self xmlParser parse: httpResponse contents.
	(AWSError xmlData: dom root) signal
]

{ #category : #internal }
AWSTXmlErrorResponseHandler >> xmlParser [
	^ XMLDOMParser
]
