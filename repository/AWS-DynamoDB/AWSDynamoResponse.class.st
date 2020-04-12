Class {
	#name : #AWSDynamoResponse,
	#superclass : #AWSJsonObject,
	#category : #'AWS-DynamoDB-Requests'
}

{ #category : #accessing }
AWSDynamoResponse class >> neoJsonMapping: mapper [

	mapper for: self do: [ :mapping |
		self instVarNames do: [ :eachName |
			mapping mapInstVar: eachName to: eachName capitalized ] ]
]
