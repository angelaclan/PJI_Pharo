Class {
	#name : #DRTSensorLastMeasureHolder,
	#superclass : #DRTAbstractValueHolder,
	#instVars : [
		'boardId',
		'sensorName'
	],
	#category : #'PJIRiotData-Grid'
}

{ #category : #accessing }
DRTSensorLastMeasureHolder >> boardId: anInteger [ 
	boardId := anInteger
]

{ #category : #accessing }
DRTSensorLastMeasureHolder >> contents [

	^ [ 
	  ((DRTBoardContainer default findBoardById: boardId) 
		   findSensorByName: sensorName) lastMeasure asString ]
		  on: Error
		  do: [ :e | e messageText ]
]

{ #category : #accessing }
DRTSensorLastMeasureHolder >> contents: aContent [
	self error: 'Cannot modify the conent of a sensor'
]

{ #category : #accessing }
DRTSensorLastMeasureHolder >> sensorName: aString [ 
	sensorName := aString
]
