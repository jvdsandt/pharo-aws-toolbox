Class {
	#name : #AWSLogsRequest,
	#superclass : #AWSJsonObject,
	#category : #'AWS-CloudWatch-Logs-Requests'
}

{ #category : #converting }
AWSLogsRequest >> asHttpRequest: endpointUrl [
	"Create a POST request to the AWS CloudWatch Logs service with the receiver as the payload."

	| entity request |

	entity := (ZnStringEntity type: AWSUtils awsJsonMimeType)
		string: self asJsonString;
		yourself.
			
	request := (ZnRequest post: endpointUrl)
		setAccept: ZnMimeType applicationJson;
		entity: entity;
		yourself.
		
	request headers at: AWSHeaders x_amz_target put: 'Logs_20140328.', self operationName.

	^ request
]

{ #category : #accessing }
AWSLogsRequest >> operationName [

	self subclassResponsibility 
]

{ #category : #accessing }
AWSLogsRequest >> resultClass [
	"Answer the class that wraps the result of executing this request.
	Request subclasses with operations that return a meaningfull result should override this message."
	^ AWSGenericResult
]
