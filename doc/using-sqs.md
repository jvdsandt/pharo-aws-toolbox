# Using the AWS Simple Queueing Service from Smalltalk

### Directly using the SQS API
The class AWSSQService gives access to the most important SQS API calls. For most API calls need 
a subclass of AWSSQSRequest that holds all the request parameters of the API call. The api methods 
return a sublass of AWSSQSResponse. These response objects wrap the xml document of the API response 
and provide accessors for the relevant fields.

The best source of information about the SQS API calls are the 
[AWS documentation web pages](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/APIReference/API_Operations.html). 

```smalltalk
"
	Setup the credentials and region using environment variables or the aws default profile.
	Alternatively you can create them directly:
		creds := AWSCredentials accessKeyId: '<my-access-key' secretKey: '<my-secret-key>'.
		regions := 'eu-west-1'.
"
creds := AWSEnvironment defaultCredentials.
region := AWSEnvironment defaultRegionName.

"Get access to the SQS service by crearing an AWSSQService instance using our credentials and a region"
sqs := AWSSQService newWithCredentials: creds region: region.

"Create a new queue"
result := sqs createQueue: (AWSSQSCreateQueueRequest new
		queueName: 'smaltalk-test-q';
		yourself).
queueUrl := result queueUrl.

"Put a simple message on the queue"
result := sqs sendMessage: (AWSSQSSendMessageRequest new
		body: 'Hello AWS World!';
		yourself) on: queueUrl.

"Read the message from the queue and make it invisible for others for 4 seconds"
result := sqs receiveMessage: (AWSSQSReceiveMessageRequest new
		maxNumberOfMessages: 1;
		attributeNames: #( 'SenderId' 'SentTimestamp' );
		visibilityTimeout: 4;
		waitTimeSeconds: 5;
		yourself) on: queueUrl.
msg := result messages first.
Transcript cr; show: 'Received message: ', msg body.

"Delete the message from the queue"
result := sqs deleteMessage: msg receiptHandle on: queueUrl.

"Cleanup by deleting the queue"
result := sqs deleteQueue: queueUrl.
```

### Reading and writing messages using the high level SQS interface

Instead of directly using the SQS API calls to send and receive messages you van also use the 
AWSSQSWriter and AWSSQSReader classes. They provide a more high-level way of using SQS.

```smalltalk
creds := AWSEnvironment defaultCredentials.
region := AWSEnvironment defaultRegionName.

"Get access to the SQS service by crearing an AWSSQService instance using our credentials and a region"
sqs := AWSSQService newWithCredentials: creds region: region.

"Create the writer"
writer := AWSSQSWriter service: sqs queue: 'smaltalk-test-q2'.

"Write 10 messages to the queue"
1 to: 10 do: [ :index |
	| payload |
	payload := Dictionary new
		at: #name put: 'Smalltalk aws api';
		at: #index put: index;
		at: #time put: Time now;
		yourself.
	writer writeBody: (STON toString: payload) ].

"Create the reader"
reader := AWSSQSReader service: sqs queue: 'smaltalk-test-q2'.

"Read all the messages from the queue"
[ 
	| msg |
	msg := reader nextMessageIfNone: [ nil ].
	msg ifNotNil: [ 
		reader deleteMessage: msg receiptHandle.
		Transcript cr; show: 'Message: ', msg body ].
	msg notNil ] whileTrue.

"Cleanup by deleting the queue"
result := sqs deleteQueue: writer queueUrl.
```