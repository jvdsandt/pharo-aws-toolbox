Class {
	#name : #AWSSQSMessage,
	#superclass : #AWSXmlObject,
	#instVars : [
		'messageXml'
	],
	#category : #'AWS-SimpleQueueService'
}

{ #category : #accessing }
AWSSQSMessage >> body [
	^ self messageXml contentStringAt: 'Body'
]

{ #category : #initialization }
AWSSQSMessage >> initFromXmlElement: msgElement [
	messageXml := msgElement 
]

{ #category : #accessing }
AWSSQSMessage >> md5OfBody [ 
	^ self messageXml contentStringAt: 'MD5OfBody'
]

{ #category : #accessing }
AWSSQSMessage >> messageId [
	^ self messageXml contentStringAt: 'MessageId'
]

{ #category : #accessing }
AWSSQSMessage >> messageXml [
	^ messageXml
]

{ #category : #accessing }
AWSSQSMessage >> receiptHandle [ 
	^ (self messageXml contentStringAt: 'ReceiptHandle') trimmed
]
