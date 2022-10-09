Class {
	#name : #AWSEnvironment,
	#superclass : #Object,
	#category : #'AWS-Core'
}

{ #category : #accessing }
AWSEnvironment class >> defaultCredentials [
	"self defaultCredentials"

	^ self defaultCredentialsIfAbsent: [ nil ]
]

{ #category : #accessing }
AWSEnvironment class >> defaultCredentialsIfAbsent: aBlock [

	"Try to get the accessKeyId ans secretKey from the default Credentials Providers in the standard AWS manner
	See: https://docs.aws.amazon.com/sdk-for-java/v1/developer-guide/credentials.html"
	
	^ self getCredentialsFromEnvironment
		ifNil: [ self
				getCredentialsFromProfile: 'default'
				ifAbsent:
					[ self getCredentialsFrom: #AWSEC2CredentialsProvider ifAbsent: aBlock ] ]
]

{ #category : #accessing }
AWSEnvironment class >> defaultRegionName [
	"self defaultRegionName"

	^ self getRegionNameFromEnvironment 
			ifNil: [ self getRegionNameFromProfile: 'default' 
				ifAbsent: [ self error: 'No default AWS region present' ] ]
]

{ #category : #accessing }
AWSEnvironment class >> getCredentialsFrom: aClassSymbol ifAbsent: aBlock [
	^ (self isProviderLoaded: aClassSymbol)
		ifTrue: [ (self environment at: aClassSymbol) getCredentialsIfAbsent: [ aBlock value ] ]
		ifFalse: [ aBlock value ]
]

{ #category : #utilities }
AWSEnvironment class >> getCredentialsFromEnvironment [
	^ self
		getCredentialsFrom: #AWSEnvironmentCredentialsProvider
		ifAbsent: [ nil ]
]

{ #category : #utilities }
AWSEnvironment class >> getCredentialsFromProfile: profileName ifAbsent: aBlock [
	"Try to get the accessKeyId ans secretKey from the specified profile
	 in the standard AWS config file '~/.aws/credentials'"
	
	"self getCredentialsFromProfile: 'default' ifAbsent: [ nil ]"
	
	| ref contents index propIndex accessKeyId secretKey sessionToken|
	
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
		
	propIndex := contents indexOfSubCollection: 'aws_session_token' startingAt: index ifAbsent: [ ^AWSCredentials accessKeyId: accessKeyId secretKey: secretKey ].
	sessionToken := contents readStream
		position: propIndex;
		upTo: $=;
		nextLine.
		
	^ AWSCredentials accessKeyId: accessKeyId secretKey: secretKey sessionToken: sessionToken
]

{ #category : #utilities }
AWSEnvironment class >> getRegionNameFromEnvironment [
	"Try to get AWS Region from a OS environment variable. Answer nil if the
	variable is not defined."

	^ OSEnvironment current at: 'AWS_DEFAULT_REGION' ifAbsent: [ nil ]
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

{ #category : #accessing }
AWSEnvironment class >> hasDefaultCredentials [

	^[ self defaultCredentials notNil ]
		on: Error do: [ :ex | ex return: false ]
]

{ #category : #accessing }
AWSEnvironment class >> isProviderLoaded: aSymbol [
	^ Smalltalk globals includesKey: aSymbol
]
