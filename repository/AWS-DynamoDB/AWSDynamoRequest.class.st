Class {
	#name : #AWSDynamoRequest,
	#superclass : #AWSJsonObject,
	#category : #'AWS-DynamoDB'
}

{ #category : #converting }
AWSDynamoRequest >> asHttpRequest: endpointUrl [
	"Create a POST request to the AWS DynamoDB service with the receiver as the payload."

	| entity request |

	entity := (ZnStringEntity type: AWSUtils awsJson10MimeType)
		string: self asJsonString;
		yourself.
			
	request := (ZnRequest post: endpointUrl)
		setAccept: ZnMimeType applicationJson;
		entity: entity;
		yourself.
		
	request headers at: AWSHeaders x_amz_target put: 'DynamoDB_20120810.', self operationName.

	^ request
]

{ #category : #accessing }
AWSDynamoRequest >> operationName [

	self subclassResponsibility
]
