## Pharo Lambda Runtime

To implement a Lambda function in Smalltalk you need the following:

- A Smalltalk VM (64 bits Linux version)
- A Smalltalk image
- Smalltalk code that runs on startup and calls the Lambda Runtime API to get tasks to execute
- A file named bootstrap that the Lambda runtime will execute
- A Smalltalk library to access the AWS logging service (CloudWatch Logs) so your function can log information.

This project provides everything you need, including some [sample functions](pharo-lambda-demo.md).
AWS Lambda offers a lot of options how to trigger a Lambda Function and what other services you 
can access from your function. The sample function uses the AWS API Gateway to implement
a REST service.

#### The Smalltalk VM

A standard 64 Linux VM works fine. The runtime environment does not support setting the thread priority so it's
best to use a VM with the Timer Heartbeat. It's possible to include the VM with each function you deploy but 
this is not very efficient. A better solution is to package the VM as a reusable Lambda Layer so you can use 
it for multiple functions. A Lambda Layer can also be made public so it can be reused by other AWS accounts.

Currently the following public layers are available:

| Date | Name | Version ARN | Contents |
| --- | --- | --- | --- |
| 2019-02-23 | Pharo70-runtime | arn:aws:lambda:eu-west-1:544477632270:layer:Pharo70-runtime:1 | Standard Pharo stable VM (5.0-201901051900) |
| 2018-12-07 | Pharo61-runtime | arn:aws:lambda:eu-west-1:544477632270:layer:Pharo61-runtime:3 | Standard Pharo stable VM (5.0-201806281256) |

This VM works with Pharo 6.1 and 7.0 64 bits images. The layer is a zip file with the Pharo Smalltalk packaged
in a bin directory. The Lambda runtime will unpack this layer in the /opt directory. The /opt/bin directory
is part of the system path so a bootstrap file could look like this.

```
#!/bin/sh
pharo --nodisplay pharo.image --no-default-preferences aws-lambda
```  

#### The AWS-Lamba-Runtime package

This Smalltalk package contains a CommandLineHandler subclass AWSLambdaCommandLineHandler. This handler
is named **aws-lambda**. It performs the following steps:

- Initialization: Read an environment variable **_HANDLER**. This variable contains the name of the
handler class. This is a Smalltalk class you write to handle incoming tasks.
- If the initialization is succesfull a message is written to the log. Otherwise the 
[Initialization Error](https://docs.aws.amazon.com/lambda/latest/dg/runtimes-api.html#runtimes-api-initerror)
api is called to tell the Lambda runtime that something went wrong.
- After initialization an endless loop first calls the 
[Next Invocation](https://docs.aws.amazon.com/lambda/latest/dg/runtimes-api.html#runtimes-api-next) api
to get the next task to execute. The payload of this task is passed to the #handleRequest: method 
of the handler class. If succesfull, the result is returned by calling the [Invocation Result](https://docs.aws.amazon.com/lambda/latest/dg/runtimes-api.html#runtimes-api-response)
api. In case of an error the [Invocation Error](https://docs.aws.amazon.com/lambda/latest/dg/runtimes-api.html#runtimes-api-invokeerror)
is called with details about the error.

The Lambda runtime enviroment will keep the Smalltalk image running for an unspecified amount of time and
kill the image if there are no new tasks for a period. Multiple images will be started when there are
more tasks coming in than a single image can handle.

#### Preparing a Smalltalk image for deployment

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

#### Demo

See the [Pharo Lambda Demo](pharo-lambda-demo.md) for a sample application that implements a REST API using the 
AWS API Gateway and Lambda functions written in Pharo Smalltalk.
