Class {
	#name : #DRTNumberValueHolder,
	#superclass : #DRTValueHolder,
	#category : #'PJIRiotData-Grid'
}

{ #category : #accessing }
DRTNumberValueHolder >> contents: aContent [

	value := aContent asNumber
]

{ #category : #accessing }
DRTNumberValueHolder >> initialize [

	super initialize.
	value := 0
]
