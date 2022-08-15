Class {
	#name : #DRTCell,
	#superclass : #Object,
	#instVars : [
		'holdr'
	],
	#category : #'PJIRiotData-Grid'
}

{ #category : #accessing }
DRTCell >> contents [

	^ self holdr contents 
]

{ #category : #accessing }
DRTCell >> contents: aString [

	(aString beginsWith: '=sensor(')
		ifTrue: [ self useSensorHolder: aString ]
		ifFalse: [ self holdr contents: aString ]
]

{ #category : #accessing }
DRTCell >> holdr [

	^ holdr ifNil: [ holdr := DRTStringValueHolder new ]
]

{ #category : #'as yet unclassified' }
DRTCell >> useSensorHolder: aString [

	| usableString indexAfterParenthesees boardSensor newHolder |
	[ 
	indexAfterParenthesees := '=sensor(' size + 1.
	usableString := aString
		                copyFrom: indexAfterParenthesees
		                to: aString size - 1.
	boardSensor := ',' split: usableString.

	newHolder := DRTSensorLastMeasureHolder new.
	newHolder boardId: boardSensor first asNumber.
	newHolder sensorName: boardSensor second.
	holdr := newHolder ]
		on: Error
		do: [ :e | self contents: 'Error ' , e messageText ]
]
