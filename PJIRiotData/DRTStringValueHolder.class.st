Class {
	#name : #DRTStringValueHolder,
	#superclass : #DRTValueHolder,
	#category : #'PJIRiotData-Grid'
}

{ #category : #accessing }
DRTStringValueHolder >> contents: aContent [

	value := aContent asString
]

{ #category : #accessing }
DRTStringValueHolder >> initialize [

	super initialize.
	value := ''
]
