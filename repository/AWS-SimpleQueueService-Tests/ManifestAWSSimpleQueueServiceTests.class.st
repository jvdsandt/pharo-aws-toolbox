"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestAWSSimpleQueueServiceTests,
	#superclass : #PackageManifest,
	#category : #'AWS-SimpleQueueService-Tests-Manifest'
}

{ #category : #'code-critics' }
ManifestAWSSimpleQueueServiceTests class >> ruleRBStringConcatenationRuleV1FalsePositive [
	^ #(#(#(#RGPackage #(#'AWS-SimpleQueueService-Tests')) #'2019-12-16T13:40:35.696538+01:00') )
]
