## Pharo Lambda Runtime

### Using the Pharo Smalltalk VM for running AWS Lambda Functions

A public layer containing the Pharo Smalltalk VM is available. See [layer-setup](layer-setup.md) for details.


### Preparing a Smalltalk image for deployment

The Lambda runtime environment is based on a 64 bits Linux operating system. The Smalltalk image has readonly access 
to the filesystem. Any attamp to create a new file or open a file in write mode will result in an error. A standard
Pharo Smalltalk development image will create and open some file in write mode at startup. For example the changes file. 

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
 
With the new bootstrap and modular setup of Pharo 7 it should be possible to create a much smaller en better suited
runtime image for AWS Lambda.