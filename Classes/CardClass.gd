extends Resource
class_name Card
#how expensive is this to buy from the shop
@export var price:int = 0
#how many enemies must this card target
@export var maxTargets:int = 0
#number of other cards that must be discarded to play this card
@export var discardCost:int = 0
@export var tags:Array
@export var drawActions:Array[Action]
@export var playActions:Array[Action]
@export var discardActions:Array[Action]
@export var icon:Texture2D
@export var title:String
@export var text:String

#array of enemies the card is targetting
var targets:Array[Enemy]

#when drawn execute all draw effects
func drawEffect():
	for i:Action in drawActions:
		i.resolve(targets)

#when played execute all play effects
func playEffect():
	for i:Action in playActions:
		i.resolve(targets)

#when discarded execute all discard effects
func discardEffect():
	for i:Action in discardActions:
		i.resolve(targets)
