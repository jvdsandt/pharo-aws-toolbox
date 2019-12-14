Class {
	#name : #AWSSQSListQueuesResponse,
	#superclass : #AWSSQSResponse,
	#instVars : [
		'queueUrls'
	],
	#category : #'AWS-SimpleQueueService'
}

{ #category : #accessing }
AWSSQSListQueuesResponse >> queueUrls [
	^ ((self resultXml elementsAt: 'QueueUrl')
			collect: [ :each | each contentString ]) asArray
]
