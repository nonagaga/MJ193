extends Resource
class_name Card
@export var price:int = 0
@export var damage:int = 0
@export var maxTargets:int = 0
#number of other cards that must be discarded to play this card
@export var discardCost:int = 0
@export var tags:Array
@export var drawActions:Array[Action]
@export var playActions:Array[Action]
@export var discardActions:Array[Action]
#array of enemies the card is targetting
var targets:Array[Enemy]

func drawEffect():
	for i:Action in drawActions:
		i.resolve(targets)

func playEffect():
	for i:Action in playActions:
		i.resolve(targets)

func discardEffect():
	for i:Action in discardActions:
		i.resolve(targets)
