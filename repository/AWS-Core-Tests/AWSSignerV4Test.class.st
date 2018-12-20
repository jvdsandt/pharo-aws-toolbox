Class {
	#name : #AWSSignerV4Test,
	#superclass : #TestCase,
	#category : #'AWS-Core-Tests'
}

{ #category : #'as yet unclassified' }
AWSSignerV4Test >> getTestCredentials [

	^ AWSCredentials accessKeyId: 'access' secretKey: 'secret'
]

{ #category : #tests }
AWSSignerV4Test >> testCloudWatchCreateLogGroup [

	| contents entity request |
	
	contents := Dictionary new
		at: 'logGroupName' put: 'MyTestLogGroup';
		yourself.
		
	entity := ZnStringEntity type: (ZnMimeType main: 'application' sub: 'x-amz-json-1.1').
	entity string: (NeoJSONWriter toStringPretty: contents).
	
	request := ZnRequest post: 'https://logs.eu-west-1.amazonaws.com'.
	request 
		setAccept: ZnMimeType applicationJson;
		entity: entity.
		
	request headers at: 'X-Amz-Target' put: 'Logs_20140328.CreateLogGroup'.
	
	AWSSignerV4 new sign: request using: self getTestCredentials.
]

{ #category : #tests }
AWSSignerV4Test >> testGetCanonicalizedHeaderString [

	| headers expected |
	
	headers := ZnHeaders new.
	headers
		at: 'Host' put: 'iam.amazonaws.com';
		at: 'Content-Type' put: 'application/x-www-form-urlencoded; charset=utf-8';
		at: 'My-header1' put: '    a   b   c  ';
		at: 'X-Amz-Date' put: '20150830T123600Z';
		at: 'My-Header2' put: '  "a   b   c" '.
		
	expected := String streamContents: [ :s |
		s
			nextPutAll: 'content-type:application/x-www-form-urlencoded; charset=utf-8'; lf;
			nextPutAll: 'host:iam.amazonaws.com'; lf;
			nextPutAll: 'my-header1:a b c'; lf;
			nextPutAll: 'my-header2:"a b c"'; lf;
			nextPutAll: 'x-amz-date:20150830T123600Z'; lf ].
			
	self assert: expected equals: (AWSSignerV4 new getCanonicalizedHeaderString: headers)
]

{ #category : #tests }
AWSSignerV4Test >> testGetCanonicalizedQueryString [

	| url |
	
	url := '/' asUrl.
	self assert:((AWSSignerV4 new getCanonicalizedQueryString: url) = '').
	
	url := '/?c=2&Z=1' asUrl.
	self assert:((AWSSignerV4 new getCanonicalizedQueryString: url) = 'Z=1&c=2').
	
	url := '/?c=2&Z=1&c=9&c=8' asUrl.
	self assert:((AWSSignerV4 new getCanonicalizedQueryString: url) = 'Z=1&c=2&c=8&c=9').

	url := '/?a c=33' asUrl.
	self assert:((AWSSignerV4 new getCanonicalizedQueryString: url) = 'a%20c=33').
	
	url := '/?D=3&b=2&Z=1' asUrl.
	self assert:((AWSSignerV4 new getCanonicalizedQueryString: url) = 'D=3&Z=1&b=2').
	
	url := '/?foasdfasd  o=Zoo&foo=boo&D=aaa&GS=xxxx' asUrl.
	self assert:((AWSSignerV4 new getCanonicalizedQueryString: url) = 'D=aaa&GS=xxxx&foasdfasd%20%20o=Zoo&foo=boo').
]

{ #category : #tests }
AWSSignerV4Test >> testGetSignedHeadersString [

	| headers expected |
	
	headers := ZnHeaders new.
	headers
		at: 'Host' put: 'iam.amazonaws.com';
		at: 'Content-Type' put: 'application/x-www-form-urlencoded; charset=utf-8';
		at: 'My-header1' put: '    a   b   c  ';
		at: 'X-Amz-Date' put: '20150830T123600Z';
		at: 'My-Header2' put: '  "a   b   c" '.
		
	expected := 'content-type;host;my-header1;my-header2;x-amz-date'.
			
	self assert: expected equals: (AWSSignerV4 new getSignedHeadersString: headers).
]

{ #category : #tests }
AWSSignerV4Test >> testHashBytesAsHex [

	self assert: 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855' 
		equals: (AWSSignerV4 new hashBytesAsHex: #[])
]

{ #category : #tests }
AWSSignerV4Test >> testHashEmptyJsonStringAsHex [

	self assert: '44136fa355b3678a1146ad16f7e8649e94fb4fc21fe77e8310c060f61caaff8a' 
		equals: (AWSSignerV4 new hashBytesAsHex: '{}')
]

{ #category : #tests }
AWSSignerV4Test >> testHashStringAsHex [

	self assert: 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855' 
		equals: (AWSSignerV4 new hashBytesAsHex: '')
]
