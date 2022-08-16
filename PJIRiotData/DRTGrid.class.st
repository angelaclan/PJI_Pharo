Class {
	#name : #DRTGrid,
	#superclass : #Object,
	#instVars : [
		'rows',
		'cellsPerRow'
	],
	#category : #'PJIRiotData-Grid'
}

{ #category : #'instance creation' }
DRTGrid class >> open: aString [

	^ STON fromStream: aString asFileReference readStream
]

{ #category : #adding }
DRTGrid >> addNewRow [

	rows add: (DRTRow new
			 rowSize: self cellsPerRow;
			 yourself)
]

{ #category : #'as yet unclassified' }
DRTGrid >> cellsPerRow [

	^ cellsPerRow ifNil: [ cellsPerRow := 6]
]

{ #category : #'as yet unclassified' }
DRTGrid >> defaultRowAmount [

	^ 15
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

{ #category : #saving }
DRTGrid >> saveAs: aString [

	| stream |
	stream := aString asFileReference writeStream.
	STON put: self onStream: stream.
	stream
		flush;
		close
]
