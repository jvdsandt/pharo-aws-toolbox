Class {
	#name : #AWSDescribeLogGroupsRequest,
	#superclass : #AWSLogsRequest,
	#instVars : [
		'limit',
		'logGroupNamePrefix',
		'nextToken'
	],
	#category : #'AWS-CloudWatch-Logs-Requests'
}

{ #category : #accessing }
AWSDescribeLogGroupsRequest >> limit [
	^ limit
]

{ #category : #accessing }
AWSDescribeLogGroupsRequest >> limit: anObject [
	limit := anObject
]

{ #category : #accessing }
AWSDescribeLogGroupsRequest >> logGroupNamePrefix [
	^ logGroupNamePrefix
]

{ #category : #accessing }
AWSDescribeLogGroupsRequest >> logGroupNamePrefix: anObject [
	logGroupNamePrefix := anObject
]

{ #category : #accessing }
AWSDescribeLogGroupsRequest >> nextToken [
	^ nextToken
]

{ #category : #accessing }
AWSDescribeLogGroupsRequest >> nextToken: anObject [
	nextToken := anObject
]

{ #category : #accessing }
AWSDescribeLogGroupsRequest >> operationName [

	^ 'DescribeLogGroups'
]

{ #category : #accessing }
AWSDescribeLogGroupsRequest >> resultClass [
	^ AWSDescribeLogGroupsResult
]
