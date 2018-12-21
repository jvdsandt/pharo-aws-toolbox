Class {
	#name : #AWSXmlObject,
	#superclass : #Object,
	#category : #'AWS-SimpleStorageService'
}

{ #category : #'instance creation' }
AWSXmlObject class >> fromXmlString: aString [

	| xmlDoc |
	
	xmlDoc := XMLDOMParser parse: aString.
	^ self new initFromXmlElement: xmlDoc root
]
