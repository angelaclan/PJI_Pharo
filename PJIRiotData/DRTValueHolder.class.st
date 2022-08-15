Class {
	#name : #DRTValueHolder,
	#superclass : #DRTAbstractValueHolder,
	#instVars : [
		'value'
	],
	#category : #'PJIRiotData-Grid'
}

{ #category : #accessing }
DRTValueHolder >> contents [

	^ value asString
]
