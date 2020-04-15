Class {
	#name : #AWSDynamoItem,
	#superclass : #Object,
	#instVars : [
		'attributes'
	],
	#category : #'AWS-DynamoDB-DataTypes'
}

{ #category : #accessing }
AWSDynamoItem class >> neoJsonMapping: mapper [

	mapper for: self customDo: [ :mapping |
		mapping
			reader: [ :jsonReader | self newWith: (self readAttributeMap: jsonReader) ];
			encoder: [ :v | v asDynamoAttributeValue  ] ]
]

{ #category : #'instance creation' }
AWSDynamoItem class >> newWith: aDictionary [
	^ self new initWith: aDictionary
]

{ #category : #accessing }
AWSDynamoItem class >> readAttributeList: jsonReader [

	^ Array streamContents: [ :stream |
			jsonReader parseListDo: [ 
				jsonReader parseMapKeysDo: [ :attribType |
					stream nextPut: (self readAttributeValue: jsonReader type: attribType) ] ] ]
]

{ #category : #accessing }
AWSDynamoItem class >> readAttributeMap: jsonReader [

	| attributes |
	
	attributes := Dictionary new.
	jsonReader consumeWhitespace.
	jsonReader parseMapKeysDo: [ :attribName |
		jsonReader parseMapKeysDo: [ :attribType |
			| attribValue |
			attribValue := self readAttributeValue: jsonReader type: attribType.
			attributes at: attribName put: attribValue ] ].
	^ attributes
]

{ #category : #accessing }
AWSDynamoItem class >> readAttributeValue: jsonReader type: attribType [

	^ attribType = 'M'
			ifTrue: [ self readAttributeMap: jsonReader ]
			ifFalse: [ 
				attribType = 'L'
					ifTrue: [ self readAttributeList: jsonReader ]
				 	ifFalse: [ AWSDynamoAttributeValue convert: jsonReader parseValue type: attribType ] ]
]

{ #category : #accessing }
AWSDynamoItem >> at: attribName [
	^ self at: attribName ifAbsent: [ self error: 'Unknown attribute' ]
]

{ #category : #accessing }
AWSDynamoItem >> at: attribName ifAbsent: aBlock [
	^ attributes at: attribName ifAbsent: [ aBlock ]
]

{ #category : #accessing }
AWSDynamoItem >> at: attribName put: attribValue [
	^ attributes at: attribName put: attribValue
]

{ #category : #accessing }
AWSDynamoItem >> attributeNames [
	^ attributes keys
]

{ #category : #accessing }
AWSDynamoItem >> attributes [
	^ attributes
]

{ #category : #'gt-inspector-extension' }
AWSDynamoItem >> gtInspectorItemsIn: composite [
	<gtInspectorPresentationOrder: 0>

	^ (composite fastTable)
		title: 'Attributes';
		display: [ self attributes associations ];
		column: 'Name' 
			evaluated: [:each | GTObjectPrinter asTruncatedTextFrom: each key ];
		column: 'Value' 
			evaluated: [:each | GTObjectPrinter asTruncatedTextFrom: each value ]
]

{ #category : #initialization }
AWSDynamoItem >> initWith: aDictionary [

	attributes := aDictionary
]

{ #category : #printing }
AWSDynamoItem >> printElementsOn: aStream [ 
	aStream nextPut: $(.
	self attributeNames sorted
		do: [ :key | aStream print: key;
			 nextPutAll: '->';				
			 print: (self at: key);
			 space ].
	aStream nextPut: $)
]

{ #category : #printing }
AWSDynamoItem >> printOn: aStream [ 
	"Append a sequence of characters that identify the receiver to aStream."

	super printOn: aStream.
	self printElementsOn: aStream
]
