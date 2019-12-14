Class {
	#name : #AWSSQSResponse,
	#superclass : #AWSXmlObject,
	#instVars : [
		'resultXml',
		'metadataXml'
	],
	#category : #'AWS-SimpleQueueService'
}

{ #category : #initialization }
AWSSQSResponse >> initFromXmlElement: rootElement [

	resultXml := rootElement elements first.
	metadataXml := rootElement elementAt: 'ResponseMetadata'.
]

{ #category : #accessing }
AWSSQSResponse >> metadataXml [
	^ metadataXml
]

{ #category : #accessing }
AWSSQSResponse >> requestId [
	^ self metadataXml contentStringAt: 'RequestId'
]

{ #category : #accessing }
AWSSQSResponse >> resultXml [
	^ resultXml
]
