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

{ #category : #'instance creation' }
AWSError class >> xmlData: rootElement [

	rootElement name = 'Error'
		ifTrue: [ ^self xmlErrorData: rootElement ].
	rootElement name = 'ErrorResponse'
		ifTrue: [ ^ self xmlErrorResponseData: rootElement ].

	^ self data: (Array with: 'Error' -> rootElement asString) asDictionary
]

{ #category : #'instance creation' }
AWSError class >> xmlErrorData: rootElement [

	| data msg |
	
	self assert: rootElement name = 'Error'.
	data := Dictionary new.
	rootElement elementsDo: [ :each |
		data at: each name put: each contentString ].
	
	msg := (data at:'Code' ifAbsent: [ '' ]), ' - ', (data at: 'Message' ifAbsent: [ '' ]).

	^ self new
			data: data;
			signal: msg
]

{ #category : #'instance creation' }
AWSError class >> xmlErrorResponseData: rootElement [

	self assert: rootElement name = 'ErrorResponse'.
	^ self xmlErrorData: (rootElement elementAt: 'Error')
	

]

{ #category : #accessing }
AWSError >> code [
	^ data ifNotNil: [ data at: 'Code' ifAbsent: [ nil ] ]
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

{ #category : #accessing }
AWSError >> type [
	^ data ifNotNil: [ data at: 'Type' ifAbsent: [ nil ] ]
]
