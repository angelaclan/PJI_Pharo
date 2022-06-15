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
		print: self timestamp;
		nextPutAll: self unit;
		nextPutAll: ' ';
		print: value
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

	^ unit ifNil: [ #units ]
]

{ #category : #accessing }
DRTMeasure >> value [

	value ifNil: [self error: 'Value id is nil' ].
	^ value.
]

{ #category : #accessing }
DRTMeasure >> value: anObject [

	value := anObject
]
