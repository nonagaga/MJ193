extends Node2D
class_name Enemy
@export var maxHP:int
@export var hp:int
@export var speed:int
@export var dmg:int
#how expensive is the enemy for our algorithm to spawn
@export var points:int

#overwritable function for when an enemy attacks
func attackTrigger():
	pass

#overwritable function for when an enemy is damaged
func damagedTrigger():
	pass

#overwritable function for when an enemy dies
func deathTrigger():
	pass

#overwritable function for when an enemy spawns
func entersTrigger():
	pass

func damaged(dmg:int):
	damagedTrigger()
	hp -= dmg
