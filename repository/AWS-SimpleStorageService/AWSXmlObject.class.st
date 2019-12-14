Class {
	#name : #AWSXmlObject,
	#superclass : #Object,
	#category : #'AWS-SimpleStorageService'
}

{ #category : #'instance creation' }
AWSXmlObject class >> fromXmlElement: anElement [
	^ self new initFromXmlElement: anElement
]

{ #category : #'instance creation' }
AWSXmlObject class >> fromXmlString: aString [

	| xmlDoc |
	
	xmlDoc := XMLDOMParser parse: aString.
	^ self fromXmlElement: xmlDoc root
]
