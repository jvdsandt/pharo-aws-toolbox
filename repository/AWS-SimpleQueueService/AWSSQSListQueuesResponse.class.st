Class {
	#name : #AWSSQSListQueuesResponse,
	#superclass : #AWSXmlObject,
	#instVars : [
		'queueUrls'
	],
	#category : #'AWS-SimpleQueueService'
}

{ #category : #initialization }
AWSSQSListQueuesResponse >> initFromXmlElement: rootElement [

	| result |

	result := rootElement elementAt: 'ListQueuesResult'.
	queueUrls := ((result elementsAt: 'QueueUrl') collect: [ :each | each contentString ]) asArray
]

{ #category : #accessing }
AWSSQSListQueuesResponse >> queueUrls [
	^ queueUrls
]
