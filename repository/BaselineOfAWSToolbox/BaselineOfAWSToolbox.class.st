Class {
	#name : #BaselineOfAWSToolbox,
	#superclass : #BaselineOf,
	#category : #BaselineOfAWSToolbox
}

{ #category : #baselines }
BaselineOfAWSToolbox >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ 
			spec
				baseline: 'NeoJSON'
				with: [ 
					spec
						repository: 'github://svenvc/NeoJSON:master/repository';
						loads: 'core' ].
			spec
				baseline: 'XMLParser'
				with: [ 
					spec
						repository: 'github://pharo-contributions/XML-XMLParser/src';
						loads: 'Core' ].
			spec
				package: 'AWS-Core' with: [ spec requires: #( 'NeoJSON' ) ];
				package: 'AWS-Core-Tests' with: [ spec requires: #( 'AWS-Core' ) ];
				package: 'AWS-CloudWatch-Logs' with: [ spec requires: #( 'AWS-Core' ) ];
				package: 'AWS-CloudWatch-Logs-Tests' with: [ spec requires: #( 'AWS-CloudWatch-Logs' ) ];
				package: 'AWS-Lambda-Runtime' with: [ spec requires: #( 'AWS-CloudWatch-Logs' ) ];
				package: 'AWS-Lambda-Runtime-Tests' with: [ spec requires: #( 'AWS-Lambda-Runtime' ) ].
				
			spec 
				package: 'AWS-SimpleStorageService' with: [ spec requires: #( 'AWS-Core' 'XMLParser' ) ];
				package: 'AWS-SimpleStorageService-Tests' with: [ spec requires: #( 'AWS-SimpleStorageService' ) ].
				
			spec 
				package: 'AWS-SimpleQueueService' with: [ spec requires: #( 'AWS-Core' 'XMLParser' ) ];
				package: 'AWS-SimpleQueueService-Tests' with: [ spec requires: #( 'AWS-SimpleQueueService' ) ].

			spec 
				group: 'Core' with: #( 'AWS-Lambda-Runtime' 'AWS-SimpleStorageService' 'AWS-SimpleQueueService' );
				group: 'Tests' with: #( 'AWS-Lambda-Runtime-Tests' 'AWS-SimpleStorageService-Tests' 'AWS-SimpleQueueService-Tests' );
				group: 'default' with: #( 'Core' 'Tests' ) ] 
]
