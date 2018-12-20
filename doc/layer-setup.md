
## A reusable layer with the Smalltalk VM

Pharo Smalltalk is not (yet?) one of the standard supported AWS Lambda runtimes. Since November 2018 AWS Lambda 
supports custom runtimes. By packaging the Pharo Smalltalk VM as a "layer" it can be used as a custom runtime for your 
Lambda functions.

The layer is just a zip file with a standard 64bit VM in a bin subdirectory. The AWS Lambda runtime copies the contents 
of the zip file to the /opt folder and adds the /opt/bin folder to the PATH environment variable.

### Public Layers with the Pharo Smalltalk VM

Currently the following public layers are available:

| Date | Name | Version ARN | Contents |
| --- | --- | --- | --- |
| 2018-12-07 | Pharo61-runtime | arn:aws:lambda:eu-west-1:544477632270:layer:Pharo61-runtime:3 | Standard Pharo stable VM (5.0-201806281256) |


### How to create a layer with the Smalltalk VM

### Make the layer publicly available:

``
aws lambda add-layer-version-permission --layer-name Pharo61-runtime \
--statement-id public-read --version-number 3 --principal '*' \
--action lambda:GetLayerVersion
``