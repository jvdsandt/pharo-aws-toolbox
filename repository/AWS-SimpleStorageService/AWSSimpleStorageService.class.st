Class {
	#name : #AWSSimpleStorageService,
	#superclass : #AWSS3Service,
	#category : #'AWS-SimpleStorageService'
}

{ #category : #operations }
AWSSimpleStorageService >> getBuckets [

	| httpRequest response |

	httpRequest := ZnRequest get: self endpoint.
	self signRequest: httpRequest.
	
	response := self httpClient 
		request: httpRequest;
		execute;
		response.
		
	response isSuccess 
		ifFalse: [ self handleErrorResponse: response ].
		
	^ AWSS3ListAllMyBucketsResult fromXmlString: response contents

]

{ #category : #testing }
AWSSimpleStorageService >> hasBucket: bucketName [

	^ [ self head: bucketName. true ] 
			on: AWSNotFoundError do: [ :ex | ex return: false ]
]

{ #category : #operations }
AWSSimpleStorageService >> head: bucketName [

	| httpRequest response |

	httpRequest := ZnRequest head: self endpoint asZnUrl / bucketName.
	response := self executeRequest: httpRequest.
		
	^ response
]

{ #category : #initialization }
AWSSimpleStorageService >> initEndpointWithRegion: aRegion [
	endpoint := 'https://s3-' , region asLowercase , '.amazonaws.com'
]

{ #category : #operations }
AWSSimpleStorageService >> put: bucketName [
	"Create a new bucket in the receivers region."

	| url entity httpRequest response |

	url := ZnUrl fromString: self endpoint asString.
	url host: bucketName, '.', url host.

	entity := ZnStringEntity xml: (XMLWriter new writeWith: [ :writer |
		writer tag: 'CreateBucketConfiguration' 
			attributes: { 'xmlns' -> 'http://s3.amazonaws.com/doc/2006-03-01/' }
			with: [
				writer tag: 'LocationConstraint' with: self region ] ]) asString.

	httpRequest := ZnRequest put: url.
	httpRequest entity: entity.
	response := self executeRequest: httpRequest.
		
	^ response
]
