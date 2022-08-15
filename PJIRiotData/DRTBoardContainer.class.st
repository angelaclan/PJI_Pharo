Class {
	#name : #DRTBoardContainer,
	#superclass : #Object,
	#instVars : [
		'boards'
	],
	#classInstVars : [
		'default'
	],
	#category : #'PJIRiotData-Model'
}

{ #category : #accessing }
DRTBoardContainer class >> default [
	" The building of the default board container should be consistent with the C program for the boards "
	^ default ifNil: [ 
		  default := self new.
		  (default newBoardId: 1) addSensor: (DRTPhotoResistor new
				   name: 'PhotoResistor';
				   yourself).
		  (default newBoardId: 2) addSensor: (DRTPhotoResistor new
				   name: 'PhotoResistor';
				   yourself).
		  default ]
]

{ #category : #accessing }
DRTBoardContainer >> boards [

	^ boards asOrderedCollection
]

{ #category : #'instance creation' }
DRTBoardContainer >> findBoardById: anId [

	anId ifNil: [ self error: 'Board id is nil' ].

	^ boards detect: [ :each | each id = anId ]
]

{ #category : #'instance creation' }
DRTBoardContainer >> initialize [

	super initialize.
	boards := Set new
]

{ #category : #'instance creation' }
DRTBoardContainer >> newBoardId: anInteger [

	| newboard |
	newboard := DRTBoard new.
	newboard id: anInteger.

	boards add: newboard.
	^ newboard
]
