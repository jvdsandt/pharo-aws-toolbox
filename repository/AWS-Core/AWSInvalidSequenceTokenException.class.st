Class {
	#name : #AWSInvalidSequenceTokenException,
	#superclass : #AWSError,
	#category : #'AWS-Core-Exceptions'
}

{ #category : #acccessing }
AWSInvalidSequenceTokenException >> expectedSequenceToken [

	^ self data at: 'expectedSequenceToken' ifAbsent: [ nil ]
]
