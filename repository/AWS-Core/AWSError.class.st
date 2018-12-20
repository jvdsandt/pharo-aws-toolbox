Class {
	#name : #AWSError,
	#superclass : #Error,
	#instVars : [
		'data'
	],
	#category : #'AWS-Core-Exceptions'
}

{ #category : #'instance creation' }
AWSError class >> data: aDictionary [

	^ (self subclassForErrorType: (aDictionary at: '__type')) new
			data: aDictionary;
			yourself
]

{ #category : #accessing }
AWSError class >> subclassForErrorType: aString [

	| symbol errorClass |

	aString isEmptyOrNil
		ifTrue: [ ^ self ].
		
	symbol := ('AWS', aString) asSymbol.
	errorClass := Smalltalk globals at: symbol ifAbsent: [ nil ].
	^ (errorClass isClass and: [ errorClass inheritsFrom: self ])
			ifTrue: [ errorClass ]
			ifFalse: [ self ]
		
]

{ #category : #accessing }
AWSError >> data [
	^ data
]

{ #category : #accessing }
AWSError >> data: aDictionary [

	data := aDictionary.
	self messageText: (aDictionary at: 'message' ifAbsent: [ nil ])
]
