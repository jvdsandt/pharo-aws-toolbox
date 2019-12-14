Class {
	#name : #AWSSQSAttribute,
	#superclass : #AWSXmlObject,
	#instVars : [
		'attributeXml'
	],
	#category : #'AWS-SimpleQueueService'
}

{ #category : #accessing }
AWSSQSAttribute >> attributeXml [
	^ attributeXml
]

{ #category : #initialization }
AWSSQSAttribute >> initFromXmlElement: msgElement [
	attributeXml := msgElement 
]

{ #category : #accessing }
AWSSQSAttribute >> name [
	^ self attributeXml contentStringAt: 'Name'
]

{ #category : #accessing }
AWSSQSAttribute >> value [
	^ self attributeXml contentStringAt: 'Value'
]
