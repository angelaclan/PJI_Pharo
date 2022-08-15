Class {
	#name : #DRTGrid,
	#superclass : #Object,
	#instVars : [
		'rows',
		'cellsPerRow'
	],
	#category : #'PJIRiotData-Grid'
}

{ #category : #adding }
DRTGrid >> addNewRow [

	rows add: (DRTRow new
			 rowSize: self cellsPerRow;
			 yourself)
]

{ #category : #'as yet unclassified' }
DRTGrid >> cellsPerRow [

	^ cellsPerRow ifNil: [ cellsPerRow := 5 ]
]

{ #category : #'as yet unclassified' }
DRTGrid >> defaultRowAmount [

	^ 3
]

{ #category : #initialization }
DRTGrid >> initializeDefaultRows [

	rows := OrderedCollection new: self defaultRowAmount.
	self defaultRowAmount timesRepeat: [ self addNewRow ]
]

{ #category : #accessing }
DRTGrid >> rows [

	^ rows ifNil: [ 
		  self initializeDefaultRows.
		  rows ]
]
