Class {
	#name : #DRTRow,
	#superclass : #Object,
	#instVars : [
		'cells'
	],
	#category : #'PJIRiotData-Grid'
}

{ #category : #adding }
DRTRow >> addNewCell [

	cells add: DRTCell new
]

{ #category : #accessing }
DRTRow >> cells [

	^ cells
]

{ #category : #'as yet unclassified' }
DRTRow >> deleteContent [

	cells do: #deleteContent
]

{ #category : #'as yet unclassified' }
DRTRow >> getCell: anInteger [

	^ cells at: anInteger
]

{ #category : #'as yet unclassified' }
DRTRow >> rowSize [

	^ cells size
]

{ #category : #'as yet unclassified' }
DRTRow >> rowSize: anInteger [

	cells := OrderedCollection new: anInteger.
	anInteger timesRepeat: [ self addNewCell ]
]
