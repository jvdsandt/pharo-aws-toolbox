## Pharo Lambda Runtime

To implement a Lambda function in Smalltalk you need the following:

- A Smalltalk VM (64 bits Linux version)
- A Smalltalk image
- Smalltalk code that runs on startup and calls the Lambda Runtime API to get tasks to execute
- A file named bootstrap that the Lambda runtime will execute
- A Smalltalk library to access the AWS logging service (CloudWatch Logs) so your function can log information.

This project provides everything you need, including some sample functions. AWS Lambda offers a lot of options 
how to trigger a Lambda Function and what other services you can access from your function. The sample function
uses the AWS API Gateway to implement a REST service.

#### The Smalltalk VM

A standard 64 Linux VM works fine. The runtime environment does not support setting the thread priority so it's
best to use a VM with the Timer Heartbeat. It's possible to include the VM with each function you deploy but 
this is not very efficient. A better solution is to package the VM as a reusable Lambda Layer so you can use 
it for multiple functions. A Lambda Layer can also be made public so it can be reused by other AWS accounts.

Currently the following public layers are available:

| Date | Name | Version ARN | Contents |
| --- | --- | --- | --- |
| 2018-12-07 | Pharo61-runtime | arn:aws:lambda:eu-west-1:544477632270:layer:Pharo61-runtime:3 | Standard Pharo stable VM (5.0-201806281256) |

This VM works with Pharo 6.1 and 7.0 64 bits images.

### Preparing a Smalltalk image for deployment

The Lambda runtime environment is based on a 64 bits Linux operating system. The Smalltalk image has readonly
access to the filesystem. Any attamp to create a new file or open a file in write mode will result in an error.
A standard Pharo Smalltalk development image will create and open some files in write mode at startup.
For example the changes file. 

A quick and dirty way to make a standard development image ready for running in the Lambda environment is by disabling 
some startup functionality that tries to write the the file system. You can do this by running this code just before 
you upload the image to Lamba. 

```smalltalk
SessionManager default
	unregisterClassNamed: #LGitLibrary;
	unregisterClassNamed: #OmSessionStore;
	unregisterClassNamed: #OmDeferrer;
	unregisterClassNamed: #OmStoreFactory;
	unregisterClassNamed: #SourceFileArray
```

Note that after running this code and restarting, the image is no longer suited for development.
 
With the new bootstrap and modular setup of Pharo 7 it should be possible to create a much smaller en better 
suited runtime image for AWS Lambda.