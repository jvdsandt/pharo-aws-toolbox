Class {
	#name : #AWSSQSCreateQueueResponse,
	#superclass : #AWSXmlObject,
	#instVars : [
		'queueUrl'
	],
	#category : #'AWS-SimpleQueueService'
}

{ #category : #initialization }
AWSSQSCreateQueueResponse >> initFromXmlElement: xmlElement [

	queueUrl := xmlElement contentStringAt: 'QueueUrl'.

]

{ #category : #accessing }
AWSSQSCreateQueueResponse >> queueUrl [
	^ queueUrl
]
