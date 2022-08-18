Class {
	#name : #DRTMeasure,
	#superclass : #Object,
	#instVars : [
		'timestamp',
		'value',
		'unit'
	],
	#category : #'PJIRiotData-Model'
}

{ #category : #accessing }
DRTMeasure >> printOn: aStream [

	aStream
		print: value;
		nextPutAll: self unit;
		nextPutAll: ' ';
		nextPutAll: '(';
		print: self timestamp hour;
		nextPutAll: 'h';
		print: self timestamp minutes;
		nextPutAll: 'm';
		print: self timestamp seconds;
		nextPutAll: 's)'
]

{ #category : #accessing }
DRTMeasure >> timestamp [

	^ timestamp
]

{ #category : #accessing }
DRTMeasure >> timestamp: anObject [

	timestamp := anObject
]

{ #category : #accessing }
DRTMeasure >> unit [

	^ unit ifNil: [ 'l' ]
]

{ #category : #accessing }
DRTMeasure >> value [

	value ifNil: [self error: 'Value is nil' ].
	^ value.
]

{ #category : #accessing }
DRTMeasure >> value: anObject [

	value := anObject
]
