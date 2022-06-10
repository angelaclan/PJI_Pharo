Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'id',
		'name',
		'sensor'
	],
	#category : #PJIRiotData
}

{ #category : #accessing }
Board >> id [
	^id
]

{ #category : #accessing }
Board >> name [
	^name
]

{ #category : #accessing }
Board >> sensor [
	sensor := Sensor new.
	^ sensor id.
	
]
