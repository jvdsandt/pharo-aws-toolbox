Class {
	#name : #AWSSQSMessageAttribute,
	#superclass : #AWSSQSAttribute,
	#category : #'AWS-SimpleQueueService'
}

{ #category : #accessing }
AWSSQSMessageAttribute >> binaryValue [
	^ (self attributeXml elementAt: 'Value') contentStringAt: 'BinaryValue'
]

{ #category : #accessing }
AWSSQSMessageAttribute >> dataType [
	^ (self attributeXml elementAt: 'Value') contentStringAt: 'DataType'
]

{ #category : #testing }
AWSSQSMessageAttribute >> isDataTypeBinary [
	^ self dataType beginsWith: 'Binary'
]

{ #category : #testing }
AWSSQSMessageAttribute >> isDataTypeNumber [
	^ self dataType beginsWith: 'Number'
]

{ #category : #testing }
AWSSQSMessageAttribute >> isDataTypeString [
	^ self dataType beginsWith: 'String'
]

{ #category : #accessing }
AWSSQSMessageAttribute >> stringValue [
	^ (self attributeXml elementAt: 'Value') contentStringAt: 'StringValue'
]

{ #category : #accessing }
AWSSQSMessageAttribute >> value [

	self isDataTypeBinary 
		ifTrue: [ ^ ZnBase64Encoder new decode: self binaryValue ].
	self isDataTypeNumber 
		ifTrue: [ ^ self stringValue asNumber ].
	^ self stringValue
]
