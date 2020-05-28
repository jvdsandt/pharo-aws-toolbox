Class {
	#name : #AWSSignerV4RequestParametersTest,
	#superclass : #TestCase,
	#category : #'AWS-Core-Tests'
}

{ #category : #tests }
AWSSignerV4RequestParametersTest >> testDateTime [

	| dt params |
	
	dt := DateAndTime fromString: '2018-09-07T15:16:17.123Z'.
	params := AWSSignerV4RequestParameters new initWithDatTime: dt service: 's' region: 'r'.
	
	self assert: params signingDateTime equals: dt.
	self assert: params formattedSigningDate equals: '20180907'.
	self assert: params formattedSigningDateTime equals: '20180907T151617Z'.
]

{ #category : #tests }
AWSSignerV4RequestParametersTest >> testRequest [

	| dt request params |
	
	dt := DateAndTime fromString: '2018-09-07T15:16:17Z'.
	request := ZnRequest get: 'https://logs.eu-west-1.amazonaws.com/'.
	params := AWSSignerV4RequestParameters new initWithDatTime: dt request: request.
	
	self assert: params serviceName equals: 'logs'.
	self assert: params regionName equals: 'eu-west-1'.

	request := ZnRequest get: 'http://LOGS.EU-WEST-3.AMAZONAWS.COM/BLA?A=123'.
	params := AWSSignerV4RequestParameters new initWithDatTime: dt request: request.
	
	self assert: params serviceName equals: 'logs'.
	self assert: params regionName equals: 'eu-west-3'.

]

{ #category : #tests }
AWSSignerV4RequestParametersTest >> testScope [

	| dt params |
	
	dt := DateAndTime fromString: '2018-09-07T15:16:17Z'.
	params := AWSSignerV4RequestParameters new initWithDatTime: dt service: 'logs' region: 'eu-west-1'.
	
	self assert: params scope equals: '20180907/eu-west-1/logs/aws4_request'

]
