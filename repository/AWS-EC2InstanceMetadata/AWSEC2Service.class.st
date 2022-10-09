Class {
	#name : #AWSEC2Service,
	#superclass : #Object,
	#instVars : [
		'host',
		'httpClient'
	],
	#category : #'AWS-EC2InstanceMetadata'
}

{ #category : #initialization }
AWSEC2Service >> createHttpClient [
	^ZnClient new
		loggingOff;
		systemPolicy;
		enforceHttpSuccess: false;
		enforceAcceptContentType: false;
		yourself
		
]

{ #category : #resources }
AWSEC2Service >> credentialsUrl [
	^ZnUrl fromString: self host, '/latest/meta-data/iam/security-credentials/'
]

{ #category : #api }
AWSEC2Service >> executeRequest: aRequest [
	
	self getSecurityToken 
		ifNotNil:
			[ :token | aRequest headers at: AWSHeaders x_aws_ec2_metadata_token put: token ].

	^self httpClient
		request: aRequest;
		execute;
		response
]

{ #category : #api }
AWSEC2Service >> getCredentials [
	"self new getCredentials"

	| request response role |
	role := self getRole.
	role ifNil: [ ^ nil ].
	request := ZnRequest get: self credentialsUrl / role.
	
	response := self executeRequest: request.
	
	^response contents
]

{ #category : #api }
AWSEC2Service >> getRole [
	| request response |
	
	request := ZnRequest get: self credentialsUrl.
	
	response := self executeRequest: request.
		
	response isError ifTrue: [ ^nil ].
	
	^response contents
]

{ #category : #api }
AWSEC2Service >> getSecurityToken [
	"self new getSecurityToken"
	| request response |
	
	request := ZnRequest put: self tokenUrl.
	request headers at: AWSHeaders x_aws_ec2_metadata_token_ttl_seconds put: '21600'.
	
	response := self httpClient request: request; execute; response.
	
	response isBadRequest ifTrue: [ ^nil ].
	
	^response contents
]

{ #category : #resources }
AWSEC2Service >> host [

	^host ifNil: [ host := 'http://169.254.169.254' ]
]

{ #category : #accessing }
AWSEC2Service >> httpClient [

	^httpClient ifNil: [ httpClient := self createHttpClient ] 
]

{ #category : #resources }
AWSEC2Service >> metadataUrl [
	^self host, '/latest/meta-data/'
]

{ #category : #resources }
AWSEC2Service >> tokenUrl [
	^self host, '/latest/api/token'
]

{ #category : #resources }
AWSEC2Service >> userdataUrl [
	^self host,  '/latest/user-data'
]
