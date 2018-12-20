Class {
	#name : #AWSJsonObject,
	#superclass : #Object,
	#category : #'AWS-Core'
}

{ #category : #'instance creation' }
AWSJsonObject class >> fromJsonStream: aStream [

	^ (NeoJSONReader on: aStream) nextAs: self
]

{ #category : #'instance creation' }
AWSJsonObject class >> fromJsonString: aString [

	^ self fromJsonStream: aString readStream

]

{ #category : #accessing }
AWSJsonObject class >> neoJsonMapping: mapper [
	"By default, just map all of the receivers instance variables."

	mapper for: self do: [ :mapping |
		mapping mapInstVars ]
]

{ #category : #converting }
AWSJsonObject >> asJsonString [

	^ NeoJSONWriter toString: self
]
