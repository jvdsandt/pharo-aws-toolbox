Class {
	#name : #AWSSQSSendMessageResponse,
	#superclass : #AWSSQSResponse,
	#category : #'AWS-SimpleQueueService'
}

{ #category : #accessing }
AWSSQSSendMessageResponse >> md5OfMessageAttributes [
	^ self resultXml contentStringAt: 'MD5OfMessageAttributes'
]

{ #category : #accessing }
AWSSQSSendMessageResponse >> md5OfMessageBody [
	^ self resultXml contentStringAt: 'MD5OfMessageBody'
]

{ #category : #accessing }
AWSSQSSendMessageResponse >> messageId [
	^ self resultXml contentStringAt: 'MessageId'
]
