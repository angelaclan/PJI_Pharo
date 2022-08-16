Class {
	#name : #DRTNetworkServiceOneBoardTest,
	#superclass : #TestCase,
	#instVars : [
		'service',
		'bd'
	],
	#category : #'PJIRiotData-Tests'
}

{ #category : #tests }
DRTNetworkServiceOneBoardTest >> setUp [

	super setUp.
	bd := DRTBoardContainer new.
	(bd newBoardId: 1) addSensor: (DRTPhotoResistor new 
			 name: 'photoresistor';
			 yourself).


	service := DRTNetworkConsumingService new boards: bd
]

{ #category : #tests }
DRTNetworkServiceOneBoardTest >> testBoardMismatchSensorValue20 [

	| stream |
	stream := '{"board":1,"Photoresistor":20};' readStream.
	service stream: stream.
	self should: [ service stepService ] raise: Error
]

{ #category : #tests }
DRTNetworkServiceOneBoardTest >> testBoardNo1SensorValue20 [

	| stream |
	stream :='{"board":1,"photoresistor":20};' readStream.
	service stream: stream.
	self
		assert:
		((bd findBoardById: 1) findSensorByName: #photoresistor) measures
			size
		equals: 0.
	service stepService.
	self
		assert:
		((bd findBoardById: 1) findSensorByName: #photoresistor) measures
			size
		equals: 1.
	self
		assert:
			((bd findBoardById: 1) findSensorByName: #photoresistor) measures
				last value
		equals: 20
]

{ #category : #tests }
DRTNetworkServiceOneBoardTest >> testBoardNo1SensorValueNil [

	| stream |
	stream := '{"board":1,"photoresistor":null};' readStream.
	service stream: stream.
	self
		assert:
		((bd findBoardById: 1) findSensorByName: #photoresistor) measures
			size
		equals: 0.
	service stepService.
	self
		assert:
			((bd findBoardById: 1) findSensorByName: #photoresistor) measures
				size
		equals: 0
]
