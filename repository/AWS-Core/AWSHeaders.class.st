"
A collection a class methods with often used http headers for AWS.
"
Class {
	#name : #AWSHeaders,
	#superclass : #Object,
	#category : #'AWS-Core'
}

{ #category : #constants }
AWSHeaders class >> x_amz_content_sha256 [

	^ 'x-amz-content-sha256'
]

{ #category : #constants }
AWSHeaders class >> x_amz_date [

	^ 'X-Amz-Date'
]

{ #category : #constants }
AWSHeaders class >> x_amz_security_token [

	^ 'X-Amz-Security-Token'
]

{ #category : #constants }
AWSHeaders class >> x_amz_target [

	^ 'X-Amz-Target'
]
