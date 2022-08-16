Class {
	#name : #DRTChartExample,
	#superclass : #Object,
	#category : #'PJIRiotData-Grid'
}

{ #category : #'as yet unclassified' }
DRTChartExample >> exampleChartLight [

	<script: 'self new exampleChartLight open'>
	| plottingBoard plottingMeasures names plt p |
	plottingBoard := DRTBoardContainer default findBoardById: 2.
	plottingMeasures := plottingBoard sensors anyOne measures copy.
	names := plottingMeasures withIndexCollect: [ :m :i | 
		         i \\ 50 = 0
			         ifTrue: [ 
				         String streamContents: [ :str | 
					         BasicDatePrinter default
						         printHMS: m timestamp
						         separatedBy: $:
						         on: str ] ]
			         ifFalse: [ '' ] ].
	names add: 'jocker'.

	plt := RSChart new.
	p := RSLinePlot new
		     x: (1 to: plottingMeasures size)
		     y: (plottingMeasures collect: #value).
	plt addPlot: p.

	plt title: 'Light'.
	plt
		addDecoration: RSVerticalTick new integer;
		addDecoration: (RSHorizontalTick new
				 fromNames: names;
				 useDiagonalLabel;
				 yourself).
	^ plt
]