Class {
	#name : #AWSSQSReceiveMessageResponse,
	#superclass : #AWSSQSResponse,
	#category : #'AWS-SimpleQueueService'
}

{ #category : #accessing }
AWSSQSReceiveMessageResponse >> messages [
	^ ((self resultXml elementsAt: 'Message')
			collect: [ :each | AWSSQSMessage fromXmlElement: each ]) asArray
]
