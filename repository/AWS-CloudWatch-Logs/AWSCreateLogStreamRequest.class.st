Class {
	#name : #AWSCreateLogStreamRequest,
	#superclass : #AWSLogsRequest,
	#instVars : [
		'logGroupName',
		'logStreamName'
	],
	#category : #'AWS-CloudWatch-Logs-Requests'
}

{ #category : #accessing }
AWSCreateLogStreamRequest >> logGroupName [
	^ logGroupName
]

{ #category : #accessing }
AWSCreateLogStreamRequest >> logGroupName: anObject [
	logGroupName := anObject
]

{ #category : #accessing }
AWSCreateLogStreamRequest >> logStreamName [
	^ logStreamName
]

{ #category : #accessing }
AWSCreateLogStreamRequest >> logStreamName: anObject [
	logStreamName := anObject
]

{ #category : #accessing }
AWSCreateLogStreamRequest >> operationName [

	^ 'CreateLogStream'
]
