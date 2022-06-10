Class {
	#name : #Sensor,
	#superclass : #Object,
	#instVars : [
		'id',
		'name',
		'unit'
	],
	#category : #PJIRiotData
}

{ #category : #accessing }
Sensor >> id [
	^id
]

{ #category : #accessing }
Sensor >> name [
	^name
]

{ #category : #accessing }
Sensor >> unit [
	^ Measure new
	timeStamp;
	value;
	yourself.
]
