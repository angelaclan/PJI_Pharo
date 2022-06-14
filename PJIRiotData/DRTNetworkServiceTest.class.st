Class {
	#name : #DRTNetworkServiceTest,
	#superclass : #TestCase,
	#instVars : [
		'service',
		'bd'
	],
	#category : #'PJIRiotData-Tests'
}

{ #category : #tests }
DRTNetworkServiceTest >> setUp [

	super setUp.
	bd := DRTBoardContainer new.
	(bd newBoardId: 1) addSensor: (DRTPhotoResistor new
			 name: 'photoresistor';
			 yourself).


	service := DRTNetworkConsumingService new boards: bd
]

{ #category : #tests }
DRTNetworkServiceTest >> testBoardMismatchSensorValue20 [

	| stream |
	stream :='{"board":null,"photoresistor":20};' readStream.
	service stream: stream.
	self
		assert: 
		((bd findBoardById: nil) findSensorByName: #photoresistor) measures
			size
		equals: 0.
	service stepService.
	
]

{ #category : #tests }
DRTNetworkServiceTest >> testBoardNo1SensorValue20 [

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
DRTNetworkServiceTest >> testBoardNo1SensorValueNil [

	| stream |
	stream :='{"board":1,"photoresistor":null};' readStream.
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
				last value
		equals: nil.
	self
		assert:
		((bd findBoardById: 1) findSensorByName: #photoresistor) measures
			size
		equals: 1.
	
]
