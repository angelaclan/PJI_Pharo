Class {
	#name : #PWSGrid,
	#superclass : #SpPresenter,
	#instVars : [
		'table1',
		'label',
		'selectedClasses',
		'bd',
		'boardsList'
	],
	#category : #'PJIRiotData-UI'
}

{ #category : #layout }
PWSGrid >> defaultLayout [
	^ SpBoxLayout newTopToBottom
		add: table1;
		add: label expand: false;
		yourself
]

{ #category : #layout }
PWSGrid >> initialize [

	selectedClasses := {1. 2. 3}.
	super initialize
]

{ #category : #layout }
PWSGrid >> initializePresenters [

	table1 := self newTable.
	label := self newLabel.

	self resetLabel.

	table1
		addColumn: (SpStringTableColumn
				 title: 'Article'
				 evaluated: [ :each | each asString ]);
		items: { 1. 2. 3 };
		
		addColumn: (SpStringTableColumn
				 title: 'Board'
				 evaluated: [ :each | each asString ]);
		items: bd boards;
		
		addColumn: (SpStringTableColumn
				 title: 'Sensor'
				 evaluated: [ :each | each asString ]);
		items: (self newList display: [ :sensor | sensor name ]) ;
		
		addColumn: (SpStringTableColumn
				 title: 'Value'
				 evaluated: [ :each | each asString ]);
		items: self newList ;
		beResizable.
	self setUpBoard
]

{ #category : #layout }
PWSGrid >> resetLabel [
	label label: (selectedClasses ifEmpty: [ 'No class checked' ] ifNotEmpty: [ (selectedClasses collect: #printString) joinUsing: ' - '])
]

{ #category : #initialization }
PWSGrid >> setUpBoard [

	bd := DRTBoardContainer default.

	boardsList items: bd boards.
	
	" We call this for starting the service if required. "
	DRTNetworkConsumingService startDefault.
]
