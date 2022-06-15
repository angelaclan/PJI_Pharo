Class {
	#name : #DRTNetworkServiceSensorValueTest,
	#superclass : #TestCase,
	#instVars : [
		'service',
		'bd'
	],
	#category : #'PJIRiotData-Tests'
}

{ #category : #running }
DRTNetworkServiceSensorValueTest >> setUp [

	super setUp.
	bd := DRTBoardContainer new.
	(bd newBoardId: 1) addSensor: (DRTPhotoResistor new
			 name: 'photoresistor';
			 unit;
			 yourself).


	service := DRTNetworkConsumingService new boards: bd
]

{ #category : #tests }
DRTNetworkServiceSensorValueTest >> testBoardNo1MeasureUnit [

	| stream |
	stream := '{"board":1,"photoresistor":20};' readStream.
	service stream: stream.

	self
		assert:
		((bd findBoardById: 1) findSensorByName: #photoresistor) unit
		equals: #ohms
]
