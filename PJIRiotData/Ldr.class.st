Class {
	#name : #Ldr,
	#superclass : #Sensor,
	#instVars : [
		'timeStamp',
		'value'
	],
	#category : #PJIRiotData
}

{ #category : #accessing }
Ldr >> id [ 
	^id
]

{ #category : #accessing }
Ldr >> name [ 
	^ self
]
