# Pharo AWS Toolbox

[![Build Status](https://travis-ci.org/jvdsandt/pharo-aws-toolbox.svg?branch=master)](https://travis-ci.org/jvdsandt/pharo-aws-toolbox)

This project contains packages to interact with various Amazon Web Services. Currently the following functionality is provided:

- Build Lambda functions using Pharo Smalltalk
- Writing log events to the CloudWatch Logs service

## Pharo Lambda Runtime

With [AWS Lambda](https://docs.aws.amazon.com/lambda/latest/dg/welcome.html) you can run code in the cloud without 
setting up any kind of server. AWS Lamda has build in support for some common programming languages but also supports
custom runtimes. With the Pharo Lambda runtime you can implement Lambda functions in Pharo Smalltalk. It consists of a
layer with the Smalltalk VM and a small support library for communicating with the Lambda Runtime API.

Pharo Smalltalk is a pretty efficient environment to implement Lambda functions. Functions implemented in Smalltalk 
normally don't need more than 256MB of memory to execute. This means that you can execute a million function 
calls for [free](https://aws.amazon.com/lambda/pricing/) each month.

For more details see [Pharo Lambda Runtime](doc/pharo-lambda-runtime.md).

## Installation

You can load the Pharo AWS Toolbox using Metacello:

```Smalltalk
Metacello new
  repository: 'github://jvdsandt/pharo-aws-toolbox/repository';
  baseline: 'AWSToolbox';
  load.
```

#### Dependencies

Pharo AWS Toolbox has the following dependencies:
- [NeoJSON](https://github.com/svenvc/NeoJSON) - Used for reading and writing JSON data.
- [XML-XMLParser](https://github.com/pharo-contributions/XML-XMLParser)
