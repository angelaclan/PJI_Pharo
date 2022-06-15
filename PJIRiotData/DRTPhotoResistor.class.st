Class {
	#name : #DRTPhotoResistor,
	#superclass : #DRTSensor,
	#instVars : [
		'unit'
	],
	#category : #'PJIRiotData-Model'
}

{ #category : #accessing }
DRTPhotoResistor >> initialize [ 
	super initialize.
	^ 'ohms'
]
