Class {
	#name : #AWSEnvironment,
	#superclass : #Object,
	#category : #'AWS-Core'
}

{ #category : #accessing }
AWSEnvironment class >> defaultCredentials [
	"self defaultCredentials"

	^ self getCredentialsFromEnvironment 
			ifNil: [ self getCredentialsFromProfile: 'default' 
				ifAbsent: [ self error: '' ] ]
]

{ #category : #accessing }
AWSEnvironment class >> defaultRegionName [
	"self defaultRegionName"

	^ self getRegionNameFromEnvironment 
			ifNil: [ self getRegionNameFromProfile: 'default' 
				ifAbsent: [ self error: '' ] ]
]

{ #category : #utilities }
AWSEnvironment class >> getCredentialsFromEnvironment [
	"Try to get AWS Credentials from OS environment variables. Answer nil if these
	variables are not defined."

	| accessKeyId secretKey sessionToken |
	
	accessKeyId := OSEnvironment current getEnv: 'AWS_ACCESS_KEY_ID'.
	accessKeyId isNil
		ifTrue: [ accessKeyId := OSEnvironment current getEnv: 'AWS_ACCESS_KEY' ].
		
	secretKey := OSEnvironment current getEnv: 'AWS_SECRET_KEY'.
	(accessKeyId isEmptyOrNil or: [ secretKey isEmptyOrNil ])
		ifTrue: [ ^ nil ].
	
	sessionToken := OSEnvironment current getEnv: 'AWS_SESSION_TOKEN'.
	
	^ AWSCredentials accessKeyId: accessKeyId secretKey: secretKey sessionToken: sessionToken
]

{ #category : #utilities }
AWSEnvironment class >> getCredentialsFromProfile: profileName ifAbsent: aBlock [
	"Try to get the accessKeyId ans secretKey from the specified profile
	 in the standard AWS config file '~/.aws/credentials'"
	
	"self getCredentialsFromProfile: 'default' ifAbsent: [ nil ]"
	
	| ref contents index propIndex accessKeyId secretKey |
	
	ref := (FileLocator home / '.aws/credentials') resolve.
	ref exists
		ifFalse: [ ^ aBlock value ].
		
	contents := ref contents.
	index := contents indexOfSubCollection: '[', profileName, ']' startingAt: 1 ifAbsent: [ ^ aBlock value ].
	propIndex := contents indexOfSubCollection: 'aws_access_key_id' startingAt: index ifAbsent: [ ^ aBlock value ].
	accessKeyId := contents readStream
		position: propIndex;
		upTo: $=;
		nextLine.
		
	propIndex := contents indexOfSubCollection: 'aws_secret_access_key' startingAt: index ifAbsent: [ ^ aBlock value ].
	secretKey := contents readStream
		position: propIndex;
		upTo: $=;
		nextLine.
		
	^ AWSCredentials accessKeyId: accessKeyId secretKey: secretKey
]

{ #category : #utilities }
AWSEnvironment class >> getRegionNameFromEnvironment [
	"Try to get AWS Region from a OS environment variable. Answer nil if the
	variable is not defined."
	
	^ OSEnvironment current getEnv: 'AWS_DEFAULT_REGION'
]

{ #category : #utilities }
AWSEnvironment class >> getRegionNameFromProfile: profileName ifAbsent: aBlock [
	"self getRegionNameFromProfile: 'default' ifAbsent: [ nil ]"
	
	| ref contents index propIndex regionName |
	
	ref := (FileLocator home / '.aws/config') resolve.
	ref exists
		ifFalse: [ ^ aBlock value ].
		
	contents := ref contents.
	index := contents indexOfSubCollection: '[', profileName, ']' startingAt: 1 ifAbsent: [ ^ aBlock value ].
	propIndex := contents indexOfSubCollection: 'region' startingAt: index ifAbsent: [ ^ aBlock value ].
	regionName := contents readStream
		position: propIndex;
		upTo: $=;
		nextLine.
		
	^ regionName trimmed
]
