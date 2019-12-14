Class {
	#name : #AWSSQSResponseTest,
	#superclass : #TestCase,
	#category : #'AWS-SimpleQueueService-Tests'
}

{ #category : #tests }
AWSSQSResponseTest >> testParseCreateQueueResponse [

	| input response |
	
	input := '<CreateQueueResponse>
    <CreateQueueResult>
        <QueueUrl>https://queue.amazonaws.com/123456789012/MyQueue</QueueUrl>
    </CreateQueueResult>
    <ResponseMetadata>
        <RequestId>7a62c49f-347e-4fc4-9331-6e8e7a96aa73</RequestId>
    </ResponseMetadata>
</CreateQueueResponse>'.

	response := AWSSQSCreateQueueResponse fromXmlString: input.
	self assert: response queueUrl equals: 'https://queue.amazonaws.com/123456789012/MyQueue'.
	self assert: response requestId equals: '7a62c49f-347e-4fc4-9331-6e8e7a96aa73'
]

{ #category : #tests }
AWSSQSResponseTest >> testParseListQueuesResponse [

	| input response |
	
	input := '<ListQueuesResponse>
    <ListQueuesResult>
        <QueueUrl>https://sqs.us-east-2.amazonaws.com/12/Q1</QueueUrl>
        <QueueUrl>https://sqs.us-east-2.amazonaws.com/13/Q2</QueueUrl>
    </ListQueuesResult>
    <ResponseMetadata>
        <RequestId>725275ae</RequestId>
    </ResponseMetadata>
</ListQueuesResponse>'.

	response := AWSSQSListQueuesResponse fromXmlString: input.
	self assert: response queueUrls equals: #( 
		'https://sqs.us-east-2.amazonaws.com/12/Q1'
		'https://sqs.us-east-2.amazonaws.com/13/Q2' ).
	self assert: response requestId equals: '725275ae'
]

{ #category : #tests }
AWSSQSResponseTest >> testParseReceiveMessageResponse [

	| input response messages message |
	
	input := '<ReceiveMessageResponse>
  <ReceiveMessageResult>
    <Message>
      <MessageId>5fea7756-0ea4</MessageId>
      <ReceiptHandle>
        auMZc8ZRv37sIW2iJKq3M9MFx1YvV11A2x/KSbkJ0=
      </ReceiptHandle>
      <MD5OfBody>fafb0</MD5OfBody>
      <Body>This is a test message</Body>
      <Attribute>
        <Name>SenderId</Name>
        <Value>195004372649</Value>
      </Attribute>
      <Attribute>
        <Name>SentTimestamp</Name>
        <Value>1238099229000</Value>
      </Attribute>
      <Attribute>
        <Name>ApproximateReceiveCount</Name>
        <Value>5</Value>
      </Attribute>
      <Attribute>
        <Name>ApproximateFirstReceiveTimestamp</Name>
        <Value>1250700979248</Value>
      </Attribute>
    </Message>
  </ReceiveMessageResult>
  <ResponseMetadata>
    <RequestId>b6633655</RequestId>
  </ResponseMetadata>
</ReceiveMessageResponse>'.

	response := AWSSQSReceiveMessageResponse fromXmlString: input.
	messages := response messages.
	self assert: messages size equals: 1.
	message := messages first.
	self assert: message messageId equals: '5fea7756-0ea4'.
	self assert: message receiptHandle equals: 'auMZc8ZRv37sIW2iJKq3M9MFx1YvV11A2x/KSbkJ0='.
	self assert: message md5OfBody equals: 'fafb0'.
	self assert: message body equals: 'This is a test message'.
	self assert: response requestId equals: 'b6633655'
]

{ #category : #tests }
AWSSQSResponseTest >> testParseSendMessageResponse [

	| input response |
	
	input := '<SendMessageResponse>
    <SendMessageResult>
        <MD5OfMessageBody>fafb00f</MD5OfMessageBody>
        <MD5OfMessageAttributes>3ae8f24</MD5OfMessageAttributes>
        <MessageId>5fea7756</MessageId>
    </SendMessageResult>
    <ResponseMetadata>
        <RequestId>27daac76</RequestId>
    </ResponseMetadata>
</SendMessageResponse>'.

	response := AWSSQSSendMessageResponse fromXmlString: input.
	self assert: response md5OfMessageBody equals: 'fafb00f'.
	self assert: response md5OfMessageAttributes equals: '3ae8f24'.
	self assert: response messageId equals: '5fea7756'.
	self assert: response requestId equals: '27daac76'
]
