Class {
	#name : #AWSLogGroup,
	#superclass : #AWSJsonObject,
	#instVars : [
		'arn',
		'creationTime',
		'kmsKeyId',
		'logGroupName',
		'metricFilterCount',
		'retentionInDays',
		'storedBytes'
	],
	#category : #'AWS-CloudWatch-Logs-DataTypes'
}

{ #category : #accessing }
AWSLogGroup >> arn [
	^ arn
]

{ #category : #accessing }
AWSLogGroup >> creationTime [
	^ creationTime
]

{ #category : #accessing }
AWSLogGroup >> kmsKeyId [
	^ kmsKeyId
]

{ #category : #accessing }
AWSLogGroup >> logGroupName [
	^ logGroupName
]

{ #category : #accessing }
AWSLogGroup >> metricFilterCount [
	^ metricFilterCount
]

{ #category : #initialization }
AWSLogGroup >> neoReadFrom: jsonReader [

	^ self new
		neoReadFrom: jsonReader;
		yourself
]

{ #category : #accessing }
AWSLogGroup >> retentionInDays [
	^ retentionInDays
]

{ #category : #accessing }
AWSLogGroup >> storedBytes [
	^ storedBytes
]
