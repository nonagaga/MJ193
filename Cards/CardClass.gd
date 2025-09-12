extends Node2D
class_name Card
@export var price:int = 0
@export var damage:int = 0
@export var maxTargets:int = 0
#number of other cards that must be discarded to play this card
@export var discardCost:int = 0
@export var tags:Array
#array of enemies the card is targetting
var targets:Array = []

#overwritable function for when card is drawn
func drawEffect():
	pass

#overwritable function for when card is played
func playEffect():
	pass

#overwritable function for when card is discarded
func discardEffect():
	pass
