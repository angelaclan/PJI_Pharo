Class {
	#name : #DRTNetworkConsumingService,
	#superclass : #TKTService,
	#instVars : [
		'boards',
		'port',
		'socket',
		'stream',
		'times'
	],
	#classInstVars : [
		'default',
		'interested'
	],
	#category : #'PJIRiotData-Network'
}

{ #category : #registration }
DRTNetworkConsumingService class >> interested [

	^ interested ifNil: [ interested := Set new ]
]

{ #category : #'as yet unclassified' }
DRTNetworkConsumingService class >> onPort: aPort boardContainer: aBoardContainer [

	^ self new
		  port: aPort;
		  boards: aBoardContainer;
		  yourself
]

{ #category : #'as yet unclassified' }
DRTNetworkConsumingService class >> startDefault [

	default ifNotNil: [ 
		default stop.
		default := nil ].


	default := self
		           onPort: 8809
		           boardContainer: DRTBoardContainer default.

	[ default start ]
		on: Error
		do: [ 
			self stopAll.
			default start ].
	default
	
]

{ #category : #registration }
DRTNetworkConsumingService class >> stopAll [

	^ self allInstancesDo: #stop
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
	self stepDelay: 10 milliSeconds.

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
DRTNetworkConsumingService >> setUp [

	socket := Socket newUDP.
	socket setPort: self port.
	stream := SocketStream on: socket
]

{ #category : #stepping }
DRTNetworkConsumingService >> stepService [

	[ 
	self processNextPackage.
	self times: self times + 1.
	self times > 10 ifTrue: [ 
		self times: 0.
		self class interested do: #refresh ] ]
		on: ConnectionTimedOut
		do: [ :ct | self manageConnectionTimeout: ct ]
]

{ #category : #accessing }
DRTNetworkConsumingService >> stream: aReadStream [ 
	stream := aReadStream
]

{ #category : #stepping }
DRTNetworkConsumingService >> times [

	^ times ifNil: [ times := 0 ]
]

{ #category : #stepping }
DRTNetworkConsumingService >> times: int [
	times := int. 
]
