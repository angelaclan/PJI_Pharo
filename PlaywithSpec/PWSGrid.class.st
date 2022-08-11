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
				 title: 'Number of subclasses'
				 evaluated: [ :each | each asString ]);
		items: { 1. 2. 3 };
		"items: self class environment allClasses;"beResizable
]

{ #category : #layout }
PWSGrid >> resetLabel [
	label label: (selectedClasses ifEmpty: [ 'No class checked' ] ifNotEmpty: [ (selectedClasses collect: #printString) joinUsing: ' - '])
]
