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
				package: 'AWS-Core' with: [ spec requires: #( 'NeoJSON' ) ];
				package: 'AWS-Core-Tests' with: [ spec requires: #( 'AWS-Core' ) ];
				package: 'AWS-CloudWatch-Logs' with: [ spec requires: #( 'AWS-Core' ) ];
				package: 'AWS-CloudWatch-Logs-Tests' with: [ spec requires: #( 'AWS-CloudWatch-Logs' ) ];
				package: 'AWS-Lambda-Runtime' with: [ spec requires: #( 'AWS-CloudWatch-Logs' ) ];
				package: 'AWS-Lambda-Runtime-Tests' with: [ spec requires: #( 'AWS-Lambda-Runtime' ) ].
				
			spec 
				group: 'Core' with: #( 'AWS-Lambda-Runtime' );
				group: 'Tests' with: #( 'AWS-Lambda-Runtime-Tests' );
				group: 'default' with: #( 'Core' 'Tests' ) ]
]
