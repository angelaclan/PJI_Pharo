Class {
	#name : #DRTNetworkServiceMultiBoardTest,
	#superclass : #TestCase,
	#instVars : [
		'service',
		'bd'
	],
	#category : #'PJIRiotData-Tests'
}

{ #category : #running }
DRTNetworkServiceMultiBoardTest >> setUp [

	super setUp.

	bd := DRTBoardContainer new.
	(bd newBoardId: 1) addSensor: (DRTPhotoResistor new
			 name: 'photoResistor1';
			 yourself).
	(bd newBoardId: 2) addSensor: (DRTPhotoResistor new
			 name: 'photoResistor2';
			 yourself).
	(bd newBoardId: 3) addSensor: (DRTPhotoResistor new
			 name: 'photoResistor';
			 yourself).

	service := DRTNetworkConsumingService2 new boards: bd.
]

{ #category : #tests }
DRTNetworkServiceMultiBoardTest >> testBoardsAdd3Boards [

	| stream |
	stream := '{"board":1,"photoresistor":10};' readStream.
	stream := '{"board":2,"photoresistor":20};' readStream.
	stream := '{"board":3,"photoresistor":30};' readStream.
]
