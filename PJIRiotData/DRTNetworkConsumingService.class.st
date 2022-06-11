Class {
	#name : #DRTNetworkConsumingService,
	#superclass : #TKTService,
	#instVars : [
		'boards',
		'port',
		'socket',
		'stream'
	],
	#category : #'PJIRiotData-Network'
}

{ #category : #'as yet unclassified' }
DRTNetworkConsumingService class >> onPort: aPort boardContainer: aBoardContainer [

	^ self new
		  port: aPort;
		  boards: aBoardContainer;
		  yourself
]

{ #category : #accessing }
DRTNetworkConsumingService >> boards: aDRTBoardContainer [ 
	boards := aDRTBoardContainer
]

{ #category : #stepping }
DRTNetworkConsumingService >> breakingLine [

	^ ';'
]

{ #category : #initialization }
DRTNetworkConsumingService >> initialize [

	super initialize.
	boards := OrderedCollection new
]

{ #category : #stepping }
DRTNetworkConsumingService >> manageConnectionTimeout: aConnectionTimeout [
	( '{1} {2} {3}' format: { 
			DateAndTime now asString. 
			self name . 
			aConnectionTimeout messageText traceCr
	 }) traceCr.
	
]

{ #category : #accessing }
DRTNetworkConsumingService >> name [

	^ 'DRT Consuming Service (Port: {1})' format: { port }
]

{ #category : #accessing }
DRTNetworkConsumingService >> port [

	^ port
]

{ #category : #accessing }
DRTNetworkConsumingService >> port: anInteger [ 
	port := anInteger
]

{ #category : #'as yet unclassified' }
DRTNetworkConsumingService >> processNextPackage [

	| currentRead package board allSensorNames |
	currentRead := stream upToAll: self breakingLine.
	package := STONJSON fromStream: currentRead readStream.
	board := boards findBoardById: (package at: #board).
	allSensorNames := package keys reject: [ :k | k = #board ].
	allSensorNames do: [ :sensorName |  
		(board findSensorByName: sensorName) registerMeasure:
			(package at: sensorName) ]
]

{ #category : #stepping }
DRTNetworkConsumingService >> setUp [

	socket := Socket newUDP.
	socket setPort: self port.
	stream := SocketStream on: socket
]

{ #category : #stepping }
DRTNetworkConsumingService >> stepService [

	[ self processNextPackage ]
		on: ConnectionTimedOut
		do: [ :ct | self manageConnectionTimeout: ct ]
]