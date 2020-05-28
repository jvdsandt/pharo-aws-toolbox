"
Test for the AWSSignerV4 class simular to the tests in the AWS SDK for Java.

See: https://github.com/aws/aws-sdk-java/blob/master/aws-java-sdk-core/src/test/java/com/amazonaws/auth/AWS4SignerTest.java
"
Class {
	#name : #AWSSignerV4JavaSdkTest,
	#superclass : #TestCase,
	#category : #'AWS-Core-Tests'
}

{ #category : #tests }
AWSSignerV4JavaSdkTest >> generateBasicRequest [

	| request |
	
	request := (ZnRequest post: 'http://demo.us-east-1.amazonaws.com/')
		entity: (
			(ZnStringEntity type: (ZnMimeType main: 'application' sub: 'x-amz-json-1.1'))
				string: '{"TableName": "foo"}';
				yourself);
		yourself.
				
	request headers
		at: 'x-amz-archive-description' put: 'test  test'.
		
	#( 'Content-Type' 'Content-Length' 'Accept' 'User-Agent' ) do: [ :each |
		request headers removeKey: each ].
		
	^ request
]

{ #category : #tests }
AWSSignerV4JavaSdkTest >> testSigning [

	| awsCredentials signerParams request expectedHeader |
	
	awsCredentials := AWSCredentials accessKeyId: 'access' secretKey: 'secret'.
	signerParams := AWSSignerV4RequestParameters new 
		initWithDatTime: (DateAndTime fromString: '1981-02-16T06:30:00Z') 
			service: 'demo' 
			region: 'us-east-1'.
	
	request := self generateBasicRequest.
	AWSSignerV4 new sign: request using: awsCredentials with: signerParams.
	
	expectedHeader := 'AWS4-HMAC-SHA256 Credential=access/19810216/us-east-1/demo/aws4_request, SignedHeaders=host;x-amz-archive-description;x-amz-date, Signature=77fe7c02927966018667f21d1dc3dfad9057e58401cbb9ed64f1b7868288e35a'.
	self assert: expectedHeader equals: request authorization.
	
	"Test request with 'x-amz-sha256' header"
	request := self generateBasicRequest.
	request headers at: 'x-amz-sha256' put: 'required'.
	AWSSignerV4 new sign: request using: awsCredentials with: signerParams.

	expectedHeader := 'AWS4-HMAC-SHA256 Credential=access/19810216/us-east-1/demo/aws4_request, SignedHeaders=host;x-amz-archive-description;x-amz-date;x-amz-sha256, Signature=e73e20539446307a5dc71252dbd5b97e861f1d1267456abda3ebd8d57e519951'.
	self assert: expectedHeader equals: request authorization.
]
