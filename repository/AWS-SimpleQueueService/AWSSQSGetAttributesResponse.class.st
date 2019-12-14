Class {
	#name : #AWSSQSGetAttributesResponse,
	#superclass : #AWSSQSResponse,
	#category : #'AWS-SimpleQueueService'
}

{ #category : #accessing }
AWSSQSGetAttributesResponse >> attributeAt: aName [
	self resultXml elementsAt: 'Attribute' do: [ :each |
		| attrib |
		attrib := AWSSQSAttribute fromXmlElement: each.
		attrib name = aName
			ifTrue: [ ^ attrib value ] ].
	^ nil
]

{ #category : #accessing }
AWSSQSGetAttributesResponse >> attributes [
	^ ((self resultXml elementsAt: 'Attribute')
			collect: [ :each | AWSSQSAttribute fromXmlElement: each ]) asArray
]
