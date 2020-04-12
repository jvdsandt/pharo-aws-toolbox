Class {
	#name : #AWSDynamoKeySchemaElement,
	#superclass : #Object,
	#instVars : [
		'attributeName',
		'keyType'
	],
	#category : #'AWS-DynamoDB-DataTypes'
}

{ #category : #'instance creation' }
AWSDynamoKeySchemaElement class >> name: aName keyType: aKeyType [

	^ self new initWithName: aName keyType: aKeyType
]

{ #category : #accessing }
AWSDynamoKeySchemaElement class >> neoJsonMapping: mapper [

	mapper for: self do: [ :mapping |
		self instVarNames do: [ :eachName |
			mapping mapInstVar: eachName to: eachName capitalized ] ]
]

{ #category : #accessing }
AWSDynamoKeySchemaElement >> attributeName [
	^ attributeName
]

{ #category : #initialization }
AWSDynamoKeySchemaElement >> initWithName: aName keyType: aKeyType [

	attributeName := aName.
	keyType := aKeyType
]

{ #category : #accessing }
AWSDynamoKeySchemaElement >> keyType [
	^ keyType
]
