Class {
	#name : #AWSEC2CredentialsProvider,
	#superclass : #AWSCredentialsProvider,
	#category : #'AWS-EC2InstanceMetadata'
}

{ #category : #actions }
AWSEC2CredentialsProvider class >> getCredentials [
	| json |
	json := AWSEC2Service new getCredentials.
	^ (AWSCredentials fromJsonString: json)
		provider: self;
		yourself
]
