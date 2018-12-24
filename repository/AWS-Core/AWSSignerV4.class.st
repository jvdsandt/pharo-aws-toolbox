"
I implement the AWS Signature Version 4 logic that is used for authenticating requests to AWS.
"
Class {
	#name : #AWSSignerV4,
	#superclass : #Object,
	#category : #'AWS-Core-Auth'
}

{ #category : #resources }
AWSSignerV4 class >> signingAlgorithm [

	^ 'AWS4-HMAC-SHA256'
]

{ #category : #utilities }
AWSSignerV4 class >> stringAsCompactString: aString [
	"Remove excess white space before and after values, and converts sequential spaces to a single space."

	| stream spaceOk |
	
	stream := WriteStream on: (String new: aString size).
	spaceOk := false.
	aString do: [ :eachChar |
		eachChar = Character space
			ifTrue: [ 
				spaceOk 
					ifTrue: [ stream nextPut: Character space ].
				spaceOk := false ]
			ifFalse: [ 
				stream nextPut: eachChar.
				spaceOk := true ] ].
		
	^ stream contents trimRight 
]

{ #category : #internal }
AWSSignerV4 >> buildAuthorizationHeader: aRequest signature: signature credentials: awsCredentials with: signerParams [

	^ String streamContents: [ :s |
		s
			nextPutAll: self class signingAlgorithm; space;
			nextPutAll: 'Credential=';
			nextPutAll: awsCredentials accessKeyId;
			nextPut: $/;
			nextPutAll: signerParams scope;
			nextPutAll: ', SignedHeaders=';
			nextPutAll: (self getSignedHeadersString: aRequest headers);
			nextPutAll: ', Signature=';
			nextPutAll: signature hex ]
]

{ #category : #internal }
AWSSignerV4 >> computeSignature: stringToSign key: signingKey with: signerParams [

	^ self hmacSign: (self utf8encoder encodeString: stringToSign) with: signingKey 
]

{ #category : #internal }
AWSSignerV4 >> createCanonicalRequest: aRequest contentHash: contentSha256 [

	^ String streamContents: [ :s |
		s
			nextPutAll: aRequest method; lf;
			nextPutAll: aRequest url pathPrintString; lf;
			nextPutAll: (self getCanonicalizedQueryString: aRequest url); lf;
			nextPutAll: (self getCanonicalizedHeaderString: aRequest headers); lf;
			nextPutAll: (self getSignedHeadersString: aRequest headers); lf;
			nextPutAll: contentSha256 ]
]

{ #category : #internal }
AWSSignerV4 >> createStringToSign: canonicalRequest with: signerParams [

	^String streamContents: [ :s |
		s
			nextPutAll: self signingAlgorithm; lf;
			nextPutAll: signerParams formattedSigningDateTime; lf;
			nextPutAll: signerParams scope; lf;
			nextPutAll: (self hashStringAsHex: canonicalRequest) ]
]

{ #category : #internal }
AWSSignerV4 >> deriveSigningKey: awsCredentials with: signerParams [

	| kSecret kDate kRegion kService |

	kSecret := self utf8encoder encodeString: 'AWS4', awsCredentials secretKey.
	kDate := self hmacSign: signerParams formattedSigningDate with: kSecret.
	kRegion := self hmacSign: signerParams regionName with: kDate.
	kService := self hmacSign: signerParams serviceName with: kRegion.
	^ self hmacSign: 'aws4_request' with: kService
]

{ #category : #utilities }
AWSSignerV4 >> getCanonicalizedHeaderString: aHeaders [

	| names values |
	
	names := OrderedCollection new.
	values := Dictionary new.
	aHeaders headersDo: [ :eachName :eachValue |
		| name |
		name := eachName asLowercase.
		(self listOfHeadersToIgnoreInLowerCase includes: name)
			ifFalse: [ 
				names add: name.
				values at: name put: eachValue ] ].

	^ String streamContents: [ :s |
			names sorted do: [ :eachName |
				s
					nextPutAll: (self class stringAsCompactString: eachName);
					nextPut: $:;
					nextPutAll: (self class stringAsCompactString: (values at: eachName));
					lf ] ]
]

{ #category : #utilities }
AWSSignerV4 >> getCanonicalizedQueryString: anUrl [
	"The canonicalized query string is formed by first sorting all the query
	string parameters, then URI encoding both the key and value and then
	joining them, in order, separating key value pairs with an '&'."

	| paramNames paramValues |
	
	anUrl hasQuery 
		ifFalse: [ ^'' ].
	
	paramNames := OrderedCollection new.
	paramValues := Dictionary new.

	anUrl queryKeys sorted do: [ :eachKey |
		| paramName paramValue |
		paramName := eachKey urlEncoded.
		paramValue := anUrl queryAt: eachKey.
		paramNames add: paramName.
		paramValues at: paramName put: (
			paramValue isArray
				ifTrue: [ paramValue collect: [ :each | each urlEncoded ] ]
				ifFalse: [ Array with: paramValue urlEncoded ]) ].
			
	^ String streamContents: [ :s |
			| first |
			first := true.
			paramNames do: [ :eachName |
				(paramValues at: eachName) sorted do: [ :eachValue |
					first
						ifTrue: [ first := false ]
						ifFalse: [ s nextPut: $& ].
					s nextPutAll: eachName; nextPut: $=; nextPutAll: eachValue ] ] ]
]

{ #category : #utilities }
AWSSignerV4 >> getSignedHeadersString: aHeaders [

	| names |
	
	names := OrderedCollection new.
	aHeaders headersDo: [ :eachName :eachValue |
		| name |
		name := eachName asLowercase.
		(self listOfHeadersToIgnoreInLowerCase includes: name)
			ifFalse: [ names add: name ] ].

	^ String streamContents: [ :s |
			names sorted 
				do: [ :eachName | s nextPutAll: eachName ] separatedBy: [ s nextPut: $; ] ]
]

{ #category : #utilities }
AWSSignerV4 >> hashBytes: aByteArray [

	^ SHA256 new hashMessage: aByteArray
]

{ #category : #utilities }
AWSSignerV4 >> hashBytesAsHex: aByteArray [

	^ (self hashBytes: aByteArray) hex
]

{ #category : #resources }
AWSSignerV4 >> hashFunction [

	^ SHA256
]

{ #category : #utilities }
AWSSignerV4 >> hashString: aString [

	^ self hashFunction new hashMessage: (self utf8encoder encodeString: aString)
]

{ #category : #utilities }
AWSSignerV4 >> hashStringAsHex: aString [

	^ (self hashString: aString) hex
]

{ #category : #utilities }
AWSSignerV4 >> hmacSign: aMessage with: aKeyBytes [

	| hmac |
	hmac := self hashFunction new hmac.
	^ hmac 
			key: aKeyBytes;
			digestMessage: aMessage
]

{ #category : #resources }
AWSSignerV4 >> listOfHeadersToIgnoreInLowerCase [
	^ #( 'connection' 'proxy-authorization' 'x-amzn-trace-id' )
]

{ #category : #public }
AWSSignerV4 >> sign: aRequest using: awsCredentials [

	^ self sign: aRequest using: awsCredentials with: (AWSSignerV4RequestParameters new initWithRequest: aRequest)
]

{ #category : #public }
AWSSignerV4 >> sign: aRequest using: awsCredentials with: signerParams [

	| contentSha256 canonicalRequest stringToSign signingKey signature |
	
	aRequest headers at: AWSHeaders x_amz_date put: signerParams formattedSigningDateTime.
	
	contentSha256 := self hashBytesAsHex: (aRequest hasEntity 
		ifTrue: [ aRequest entity asByteArray ]
		ifFalse: [ #[] ]).
		
	(aRequest headers at: AWSHeaders x_amz_content_sha256 ifAbsent: [ nil ]) = 'required'
		ifTrue: [ aRequest headers at: AWSHeaders x_amz_content_sha256 put: contentSha256 ].
	
	canonicalRequest := self createCanonicalRequest: aRequest contentHash: contentSha256.
	stringToSign := self createStringToSign: canonicalRequest with: signerParams.
	signingKey := self deriveSigningKey: awsCredentials with: signerParams.
	signature := self computeSignature: stringToSign key: signingKey with: signerParams.

	aRequest setAuthorization: (self buildAuthorizationHeader: aRequest 
			signature: signature
			credentials: awsCredentials
			with: signerParams)

]

{ #category : #resources }
AWSSignerV4 >> signingAlgorithm [

	^ self class signingAlgorithm
]

{ #category : #resources }
AWSSignerV4 >> utf8encoder [

	^ ZnCharacterEncoder utf8
]
