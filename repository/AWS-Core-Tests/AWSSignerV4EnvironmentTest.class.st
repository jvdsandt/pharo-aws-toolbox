Class {
	#name : #AWSSignerV4EnvironmentTest,
	#superclass : #TestCase,
	#category : #'AWS-Core-Tests'
}

{ #category : #'as yet unclassified' }
AWSSignerV4EnvironmentTest >> testHostHeaderPresentInRequest [
	
	| request |

	request := ZnRequest post: 'https://logs.eu-west-1.amazonaws.com'.
	self assert: (request headers at: 'Host') equals: 'logs.eu-west-1.amazonaws.com'.
	
	request := ZnRequest post: 'https://logs.eu-west-1.amazonaws.com:8090'.
	self assert: (request headers at: 'Host') equals: 'logs.eu-west-1.amazonaws.com:8090'.
	
	request := ZnRequest post: 'https://logs.eu-west-1.amazonaws.com:443'.
	self assert: (request headers at: 'Host') equals: 'logs.eu-west-1.amazonaws.com'.
	
	request := ZnRequest post: 'http://logs.eu-west-1.amazonaws.com:80'.
	self assert: (request headers at: 'Host') equals: 'logs.eu-west-1.amazonaws.com'.
	
	request := ZnRequest post: 'http://logs.eu-west-1.amazonaws.com:8080'.
	self assert: (request headers at: 'Host') equals: 'logs.eu-west-1.amazonaws.com:8080'.
]
