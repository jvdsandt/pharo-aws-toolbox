Class {
	#name : #AWSDynamoAttributeDefinition,
	#superclass : #Object,
	#instVars : [
		'attributeName',
		'attributeType'
	],
	#category : #'AWS-DynamoDB-DataTypes'
}

{ #category : #'instance creation' }
AWSDynamoAttributeDefinition class >> name: aName type: aTypeString [
	"Possible types: 'S', 'N' or 'B'."

	^ self new initWithName: aName type: aTypeString
]

{ #category : #accessing }
AWSDynamoAttributeDefinition class >> neoJsonMapping: mapper [

	mapper for: self do: [ :mapping |
		self instVarNames do: [ :eachName |
			mapping mapInstVar: eachName to: eachName capitalized ] ]
]

{ #category : #accessing }
AWSDynamoAttributeDefinition >> attributeName [
	^ attributeName
]

{ #category : #accessing }
AWSDynamoAttributeDefinition >> attributeType [
	^ attributeType
]

{ #category : #initialization }
AWSDynamoAttributeDefinition >> initWithName: aName type: aTypeString [

	attributeName := aName.
	attributeType := aTypeString
]
