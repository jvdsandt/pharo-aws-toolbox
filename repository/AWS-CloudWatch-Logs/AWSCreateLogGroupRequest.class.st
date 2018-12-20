Class {
	#name : #AWSCreateLogGroupRequest,
	#superclass : #AWSLogsRequest,
	#instVars : [
		'logGroupName'
	],
	#category : #'AWS-CloudWatch-Logs-Requests'
}

{ #category : #accessing }
AWSCreateLogGroupRequest >> logGroupName [
	^ logGroupName
]

{ #category : #accessing }
AWSCreateLogGroupRequest >> logGroupName: anObject [
	logGroupName := anObject
]

{ #category : #accessing }
AWSCreateLogGroupRequest >> operationName [

	^ 'CreateLogGroup'
]
