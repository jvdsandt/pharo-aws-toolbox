Class {
	#name : #AWSDynamoDB,
	#superclass : #AWSService,
	#category : #'AWS-DynamoDB'
}

{ #category : #api }
AWSDynamoDB >> getItem: aGetItemRequest [

	| httpRequest response |

	httpRequest := aGetItemRequest asHttpRequest: self endpoint.
	self signRequest: httpRequest.
	
	response := self httpClient 
		request: httpRequest;
		execute;
		response.
	response isSuccess 
		ifFalse: [ self handleErrorResponse: response ].
		
	^ AWSDynamoGetItemResponse fromJsonString: response contents
]

{ #category : #initialization }
AWSDynamoDB >> initWithCredentials: aCredentials region: aRegion [

	super initWithCredentials: aCredentials region: aRegion.
	endpoint := 'https://dynamodb.', region asLowercase, '.amazonaws.com'.
]
