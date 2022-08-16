Class {
	#name : #DRTGridRowTests,
	#superclass : #TestCase,
	#instVars : [
		'grid'
	],
	#category : #'PJIRiotData-Tests'
}

{ #category : #tests }
DRTGridRowTests >> setUp [

	super setUp.
	grid := DRTGrid new
]

{ #category : #tests }
DRTGridRowTests >> testAllTheRowsInAGridHaveTheSameSize [

	self assert:
		(grid rows allSatisfy: [ :row | row rowSize = grid rows first rowSize ])
]
