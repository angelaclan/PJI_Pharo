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

	^ default ifNil: [ default := self new ]
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
