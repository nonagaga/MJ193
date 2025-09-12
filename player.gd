extends Node2D
@export var maxHP:int
@export var hp:int
@export var maxDeckSize:int = 21
@export var deck:Array
@export var discard:Array

func damaged(dmg:int):
	hp -= dmg
