Class {
	#name : #DRTBoard,
	#superclass : #Object,
	#instVars : [
		'id',
		'name',
		'sensors'
	],
	#category : #'PJIRiotData-Model'
}

{ #category : #adding }
DRTBoard >> addSensor: aDRTPhotoResistor [

	self sensors add: aDRTPhotoResistor
]

{ #category : #accessing }
DRTBoard >> findSensorByName: aName [

	^ sensors detect: [ :s | s name = aName ]
]

{ #category : #accessing }
DRTBoard >> id [
	^id
]

{ #category : #accessing }
DRTBoard >> id: anInteger [ 
	id := anInteger
]

{ #category : #accessing }
DRTBoard >> name [

	^ name
]

{ #category : #accessing }
DRTBoard >> printOn: aStream [

	aStream
		nextPutAll: 'Board(';
		print: id;
		nextPutAll: ')'
]

{ #category : #accessing }
DRTBoard >> sensors [

	"Lazy initialization "

	^ sensors ifNil: [ sensors := Set new ]
]
