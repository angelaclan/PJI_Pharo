Class {
	#name : #PWSGrid,
	#superclass : #SpPresenter,
	#instVars : [
		'table1',
		'label',
		'selectedClasses'
	],
	#category : #PlaywithSpec
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

	selectedClasses := OrderedCollection
		                   with: ASTCache
		                   with: ASTEvaluationTest.
	super initialize
]

{ #category : #layout }
PWSGrid >> initializePresenters [

	table1 := self newTable.
	label := self newLabel.

	self resetLabel.

	table1
		addColumn: (SpStringTableColumn title: 'Object' evaluated: [ :each | each self object asString ]);
		addColumn: (SpStringTableColumn title: 'Board' evaluated: #board);
		addColumn: (SpStringTableColumn title: 'Sensor' evaluated: #sensor);
		addColumn: (SpStringTableColumn
				 title: 'Value'
				 evaluated: [ :class | class subclasses size asString ]);
		
		beResizable
]

{ #category : #layout }
PWSGrid >> object [

	^ { 'monaliso'. 'pis'. 'ushuaia' }
]

{ #category : #layout }
PWSGrid >> resetLabel [

	label label: (selectedClasses
			 ifEmpty: [ 'No class checked' ]
			 ifNotEmpty: [ 
			 (selectedClasses collect: #printString) joinUsing: ' - ' ])
]
