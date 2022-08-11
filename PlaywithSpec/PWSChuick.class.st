Class {
	#name : #PWSChuick,
	#superclass : #SpPresenter,
	#instVars : [
		'label',
		'bd',
		'boardsList',
		'sensorList',
		'valueList'
	],
	#category : #PlaywithSpec
}

{ #category : #initialization }
PWSChuick >> connectPresenters [

	boardsList whenSelectionChangedDo: [ :selection | 
		selection selectedItem
			ifNil: [ sensorList items: {  } ]
			ifNotNil: [ 
				sensorList items:
					selection selectedItem sensors asOrderedCollection ] ].

	sensorList whenSelectionChangedDo: [ :selection | 
		selection selectedItem
			ifNil: [ valueList items: {  } ]
			ifNotNil: [ valueList items: selection selectedItem measures ] ]
]

{ #category : #initialization }
PWSChuick >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  add: (SpBoxLayout newLeftToRight
				   add: (SpBoxLayout newTopToBottom
						    add: 'Board' expand: false;
						    add: boardsList;
						    yourself);
				   add: (SpBoxLayout newTopToBottom
						    add: 'Sensor' expand: false;
						    add: sensorList;
						    yourself); 
				   add: (SpBoxLayout newTopToBottom
						    add: 'Value' expand: false;
						    add: valueList;
						    yourself); 
				   yourself);
		 
		  yourself
]

{ #category : #initialization }
PWSChuick >> initializePresenters [

	super initializePresenters.
	boardsList := self newList display: [ :a | 
		              'Board: ' , a id asString ].
	label := self newLabel.

	sensorList := self newList display: [ :sensor | sensor name ].
	
	valueList := self newList.
	self setUpBoards
]

{ #category : #initialization }
PWSChuick >> setUpBoards [

	bd := DRTBoardContainer default.

	boardsList items: bd boards.
	
	" We call this for starting the service if required. "
	DRTNetworkConsumingService startDefault.
]
