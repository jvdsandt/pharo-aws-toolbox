"
I am AWSSQSReader, use me when you want to read messages from a SQS queue. 

After reading a message with #nextMessage it should be deleted using #deleteMessage. This should be done before the #visibilityTimeout or the message will be re-delivered. 

You can use the #processNextWith: method to read a message, process it using a block and delete 
the message after processing.
"
Class {
	#name : #AWSSQSReader,
	#superclass : #Object,
	#instVars : [
		'sqsservice',
		'queueUrl',
		'visibilityTimeout',
		'attributeNames',
		'messageAttributeNames'
	],
	#category : #'AWS-SimpleQueueService-Convenience'
}

{ #category : #'instance creation' }
AWSSQSReader class >> service: aSqsService queueUrl: aQueueUrl [

	^ self new initWithService: aSqsService queueUrl: aQueueUrl
]

{ #category : #accessing }
AWSSQSReader >> attributeNames [
	^ attributeNames
]

{ #category : #accessing }
AWSSQSReader >> attributeNames: anObject [
	attributeNames := anObject
]

{ #category : #actions }
AWSSQSReader >> deleteMessage: aReceiptHandle [
	"Remove a received message from the queue using its receipt handle."

	^ sqsservice deleteMessage: aReceiptHandle on: self queueUrl
]

{ #category : #initialization }
AWSSQSReader >> initWithService: aSqsService queueUrl: aQueueUrl [

	sqsservice := aSqsService.
	queueUrl := aQueueUrl
]

{ #category : #initialization }
AWSSQSReader >> initialize [

	super initialize.
	attributeNames := #().
	messageAttributeNames := #()
]

{ #category : #resources }
AWSSQSReader >> maxWaitTimeSeconds [

	^ 20
]

{ #category : #accessing }
AWSSQSReader >> messageAttributeNames [
	^ messageAttributeNames
]

{ #category : #accessing }
AWSSQSReader >> messageAttributeNames: anObject [
	messageAttributeNames := anObject
]

{ #category : #resources }
AWSSQSReader >> newDefaultRequest [

	^ AWSSQSReceiveMessageRequest new
			maxNumberOfMessages: 1;
			waitTimeSeconds: self maxWaitTimeSeconds;
			visibilityTimeout: self visibilityTimeout;
			attributeNames: self attributeNames;
			messageAttributeNames: self messageAttributeNames;
			yourself
]

{ #category : #actions }
AWSSQSReader >> nextMessage [
	"Answer the next message. Wait as long as neccesary until a message becomes available."

	| request response |
	
	request := self newDefaultRequest.
	[ 	
		response := sqsservice receiveMessage: request on: self queueUrl.
		response messages notEmpty ] whileFalse.
	^ response messages first
]

{ #category : #actions }
AWSSQSReader >> nextMessageIfNone: aBlock [
	"Answer the next message if one is available, otherwise answer the result of evaluating <aBlock>."

	| request response |
	
	request := self newDefaultRequest
		waitTimeSeconds: 0;
		yourself.
	response := sqsservice receiveMessage: request on: self queueUrl.
	^ response messages notEmpty
			ifTrue: [ response messages first ]
			ifFalse: [ aBlock value ]
]

{ #category : #actions }
AWSSQSReader >> nextMessages [
	"Answer the next messages. Wait as long as neccesary until at least one message becomes available."

	| request response |
	
	request := self newDefaultRequest 
		maxNumberOfMessages: 10;
		yourself.
	[ 	
		response := sqsservice receiveMessage: request on: self queueUrl.
		response messages notEmpty ] whileFalse.
	^ response messages
]

{ #category : #actions }
AWSSQSReader >> processAllWith: aBlock [

	[ 
		self processNextWith: aBlock.
		true 
	 ]
]

{ #category : #actions }
AWSSQSReader >> processNext [
	"Read and remove the next message from the queue."

	^ self processNextWith: [ :msg | msg ]
]

{ #category : #actions }
AWSSQSReader >> processNextWith: aBlock [
	"Read the next message from the queue, process it using <aBlock> and than 
	delete the message from the queue. If an error occurs during the processing
	the message will not be deleted from the queue and will become available again
	after the visibilityTimeout has expired."

	| msg result |

	msg := self nextMessage.
	result := aBlock value: msg.
	self deleteMessage: msg receiptHandle.
	^ result
]

{ #category : #accessing }
AWSSQSReader >> queueUrl [
	^ queueUrl
]

{ #category : #accessing }
AWSSQSReader >> visibilityTimeout [
	^ visibilityTimeout
]

{ #category : #accessing }
AWSSQSReader >> visibilityTimeout: anObject [
	visibilityTimeout := anObject
]
