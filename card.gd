extends Node2D
@export var cardRes:Card

func _ready() -> void:
	cardRes.compileCardText()
	cardRes.playEffect()
