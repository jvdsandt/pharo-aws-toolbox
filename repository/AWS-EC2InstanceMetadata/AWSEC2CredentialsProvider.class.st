Class {
	#name : #AWSEC2CredentialsProvider,
	#superclass : #AWSCredentialsProvider,
	#category : #'AWS-EC2InstanceMetadata'
}

{ #category : #actions }
AWSEC2CredentialsProvider class >> getCredentials [
	| response |
	response := AWSEC2Service new getCredentials.
	^ response
		ifNotNil: [ :json | 
			(AWSCredentials fromJsonString: json)
				provider: self;
				yourself ]
]
