Class {
	#name : #PWSGrid,
	#superclass : #SpPresenter,
	#instVars : [
		'table',
		'grid'
	],
	#category : #'PJIRiotData-UI'
}

{ #category : #layout }
PWSGrid >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  add: table;
		  yourself
]

{ #category : #accessing }
PWSGrid >> grid [
	^ grid
]

{ #category : #layout }
PWSGrid >> grid: aGrid [

	grid := aGrid.
	1 to: grid cellsPerRow do: [ :index | 
		table addColumn: (SpTextInputTableColumn
				 title: (index + 9) asHexDigit asString
				 evaluated: [ :each | (each getCell: index) contents ]
				 stored: [ :each :newValue | 
				 (each getCell: index) contents: newValue ]) ].
	table items: grid rows
]

{ #category : #layout }
PWSGrid >> initializePresenters [

	table := self newTable.
	table addColumn: (SpIndexTableColumn new
			 title: '#';
			 beNotExpandable;
			 yourself)
]
