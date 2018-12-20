Class {
	#name : #AWSInputLogEvent,
	#superclass : #AWSJsonObject,
	#instVars : [
		'message',
		'timestamp'
	],
	#category : #'AWS-CloudWatch-Logs-DataTypes'
}

{ #category : #'instance-creation' }
AWSInputLogEvent class >> message: aString [

	^ self message: aString timestamp: AWSUtils awsTimestamp
]

{ #category : #'instance-creation' }
AWSInputLogEvent class >> message: aString timestamp: anInteger [

	^ self new
			message: aString;
			timestamp: anInteger;
			yourself
]

{ #category : #accessing }
AWSInputLogEvent >> message [
	^ message
]

{ #category : #accessing }
AWSInputLogEvent >> message: anObject [
	message := anObject
]

{ #category : #accessing }
AWSInputLogEvent >> timestamp [
	"The time the event occurred, expressed as the number of milliseconds after Jan 1, 1970 00:00:00 UTC."
	^ timestamp
]

{ #category : #accessing }
AWSInputLogEvent >> timestamp: anInteger [
	"The time the event occurred, expressed as the number of milliseconds after Jan 1, 1970 00:00:00 UTC."
	timestamp := anInteger
]
