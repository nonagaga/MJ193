extends Node2D
class_name Enemy
@export var maxHP:int
@export var hp:int
@export var speed:int
@export var dmg:int
#how expensive is the enemy for our algorithm to spawn
@export var points:int
@export var animation_player : AnimationPlayer

#overwritable function for when an enemy attacks
func attackTrigger():
	if animation_player:
		animation_player.play("attack")
		await animation_player.animation_finished

#overwritable function for when an enemy is damaged
func damagedTrigger():
	if animation_player:
		animation_player.play("damaged")
		await animation_player.animation_finished

#overwritable function for when an enemy dies
func deathTrigger():
	if animation_player:
		animation_player.play("death")
		await animation_player.animation_finished

#overwritable function for when an enemy spawns
func entersTrigger():
	if animation_player:
		animation_player.play("enter")

func damaged(dmg:int):
	damagedTrigger()
	hp -= dmg
