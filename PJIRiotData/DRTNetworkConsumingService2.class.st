Class {
	#name : #DRTNetworkConsumingService2,
	#superclass : #TKTService,
	#instVars : [
		'boards',
		'port',
		'socket',
		'stream'
	],
	#classInstVars : [
		'default'
	],
	#category : #'PJIRiotData-Network'
}

{ #category : #'as yet unclassified' }
DRTNetworkConsumingService2 class >> onPort: aPort boardContainer: aBoardContainer [

	^ self new
		  port: aPort;
		  boards: aBoardContainer;
		  yourself
]

{ #category : #'as yet unclassified' }
DRTNetworkConsumingService2 class >> startDefault [

	default ifNil: [ 
		default := self
			           onPort: 8809
			           boardContainer: DRTBoardContainer default.
		[ default start ]
			on: Error
			do: [ 
				self stopAll.
				default start ].
		default ]
]

{ #category : #registration }
DRTNetworkConsumingService2 class >> stopAll [

	^ self allInstancesDo: #stop
]

{ #category : #accessing }
DRTNetworkConsumingService2 >> boards: aDRTBoardContainer [ 
	boards := aDRTBoardContainer
]

{ #category : #stepping }
DRTNetworkConsumingService2 >> breakingLine [

	^ ';'
]

{ #category : #initialization }
DRTNetworkConsumingService2 >> initialize [

	super initialize.
	boards := OrderedCollection new
]

{ #category : #stepping }
DRTNetworkConsumingService2 >> manageConnectionTimeout: aConnectionTimeout [
	( '{1} {2} {3}' format: { 
			DateAndTime now asString. 
			self name . 
			aConnectionTimeout messageText traceCr
	 }) traceCr.
	
]

{ #category : #accessing }
DRTNetworkConsumingService2 >> name [

	^ 'DRT Consuming Service (Port: {1})' format: { port }
]

{ #category : #accessing }
DRTNetworkConsumingService2 >> port [

	^ port
]

{ #category : #accessing }
DRTNetworkConsumingService2 >> port: anInteger [ 
	port := anInteger
]

{ #category : #'as yet unclassified' }
DRTNetworkConsumingService2 >> processNextPackage [
   " string format example : '{\""board\"":1,\""%s\"":%d};' "

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
DRTNetworkConsumingService2 >> setUp [

	socket := Socket newUDP.
	socket setPort: self port.
	stream := SocketStream on: socket
]

{ #category : #stepping }
DRTNetworkConsumingService2 >> stepService [

	[ self processNextPackage ]
		on: ConnectionTimedOut
		do: [ :ct | self manageConnectionTimeout: ct ]
]

{ #category : #accessing }
DRTNetworkConsumingService2 >> stream: aReadStream [ 
	stream := aReadStream
]
