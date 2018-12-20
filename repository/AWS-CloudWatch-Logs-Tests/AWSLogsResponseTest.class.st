Class {
	#name : #AWSLogsResponseTest,
	#superclass : #TestCase,
	#category : #'AWS-CloudWatch-Logs-Tests'
}

{ #category : #tests }
AWSLogsResponseTest >> testDescribeLogGroupsResult [

	| json result |
	
	json := '{
  "logGroups": [
    {
      "storedBytes": 1048576,
      "arn": "arn:aws:logs:us-east-1:123456789012:log-group:my-log-group-1:*",
      "creationTime": 1393545600000,
      "logGroupName": "my-log-group-1",
      "metricFilterCount": 0,
      "retentionInDays": 14,
      "kmsKeyId": "arn:aws:kms:us-east-1:123456789012:key/abcd1234-a123-456a-a12b-a123b4cd56ef"
    },
    {
      "storedBytes": 5242880,
      "arn": "arn:aws:logs:us-east-1:123456789012:log-group:my-log-group-2:*",
      "creationTime": 1396224000000,
      "logGroupName": "my-log-group-2",
      "metricFilterCount": 0,
      "retentionInDays": 30
    }
  ]
}'.

	result := AWSDescribeLogGroupsResult fromJsonString: json.
	self assert: result logGroups size equals: 2.
	self assert: result logGroups first logGroupName equals: 'my-log-group-1'.
	self assert: result logGroups last storedBytes equals: 5242880.
]
