
# Pharo Lambda Runtime

Support library for developing AWS Lambda functions using Pharo Smalltalk.

### Using the Pharo Smalltalk VM for running AWS Lambda Functions

A public layer containing the Pharo Smalltalk VM is available. See [layer-setup](doc/layer-setup.md) for details.


Prepare image

NoChangesLog install.
NoPharoFilesOpener install.

SessionManager default
	unregisterClassNamed: #LGitLibrary;
	unregisterClassNamed: #OmSessionStore;
	unregisterClassNamed: #OmDeferrer;
	unregisterClassNamed: #OmStoreFactory;
	unregisterClassNamed: #SourceFileArray