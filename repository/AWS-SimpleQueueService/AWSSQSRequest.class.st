Class {
	#name : #AWSSQSRequest,
	#superclass : #Object,
	#traits : 'AWSTFormUrlEncoding',
	#classTraits : 'AWSTFormUrlEncoding classTrait',
	#category : #'AWS-SimpleQueueService'
}

{ #category : #internal }
AWSSQSRequest class >> createEntityForAction: actionName [

	^ self convertEntity: (
		ZnApplicationFormUrlEncodedEntity new
			at: 'Action' put: actionName;
			at: 'Version' put: self version;
			yourself)
]

{ #category : #resources }
AWSSQSRequest class >> version [

	^ '2012-11-05'
]

{ #category : #versions }
AWSSQSRequest >> version [
	^ self class version
]
