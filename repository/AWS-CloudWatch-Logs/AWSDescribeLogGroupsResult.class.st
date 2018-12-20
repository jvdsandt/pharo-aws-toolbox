Class {
	#name : #AWSDescribeLogGroupsResult,
	#superclass : #AWSLogsResult,
	#instVars : [
		'logGroups',
		'nextToken'
	],
	#category : #'AWS-CloudWatch-Logs-Results'
}

{ #category : #accessing }
AWSDescribeLogGroupsResult class >> neoJsonMapping: mapper [

	mapper for: self do: [ :mapping |
		mapping mapInstVars: #( nextToken ).
		(mapping mapInstVar: #logGroups) valueSchema: #ArrayOfAWSLogGroup ].
	
	mapper for: #ArrayOfAWSLogGroup customDo: [ :mapping |
		mapping listOfElementSchema: AWSLogGroup ]
]

{ #category : #accessing }
AWSDescribeLogGroupsResult >> logGroups [
	^ logGroups
]

{ #category : #accessing }
AWSDescribeLogGroupsResult >> nextToken [
	^ nextToken
]
