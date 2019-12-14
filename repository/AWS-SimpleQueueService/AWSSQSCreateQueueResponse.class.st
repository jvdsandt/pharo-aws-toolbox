Class {
	#name : #AWSSQSCreateQueueResponse,
	#superclass : #AWSSQSResponse,
	#category : #'AWS-SimpleQueueService'
}

{ #category : #accessing }
AWSSQSCreateQueueResponse >> queueUrl [
	^ self resultXml contentStringAt: 'QueueUrl'.
]
