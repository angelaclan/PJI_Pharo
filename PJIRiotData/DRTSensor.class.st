Class {
	#name : #DRTSensor,
	#superclass : #Object,
	#instVars : [
		'id',
		'name',
		'measures'
	],
	#category : #'PJIRiotData-Model'
}

{ #category : #accessing }
DRTSensor >> id [
	^id
]

{ #category : #'as yet unclassified' }
DRTSensor >> measures [

	^ measures ifNil: [ measures := OrderedCollection new ]
]

{ #category : #accessing }
DRTSensor >> name [
	^name
]

{ #category : #accessing }
DRTSensor >> name: aString [ 
	name := aString
]

{ #category : #'as yet unclassified' }
DRTSensor >> printOn: aStream [

	aStream
		nextPutAll: self className;
		nextPutAll: '(';
		print: name;
		nextPutAll: ' : ';
		print: measures last;
		nextPutAll: ')'
]

{ #category : #'as yet unclassified' }
DRTSensor >> registerMeasure: anInteger [

	self measures add: (DRTMeasure new
			 value: anInteger;
			 timestamp: DateAndTime now;
			 yourself)
]

{ #category : #accessing }
DRTSensor >> unit [


	^ #ohms
]
