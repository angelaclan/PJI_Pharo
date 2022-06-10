Class {
	#name : #Measure,
	#superclass : #Object,
	#instVars : [
		'time',
		'value'
	],
	#category : #PJIRiotData
}

{ #category : #accessing }
Measure >> timeStamp [

	^ DateAndTime now
]

{ #category : #accessing }
Measure >> value [ 
	^ value
]
