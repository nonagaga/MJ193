extends Node
@export var maxHP:int
var hp:int
@export var maxDeckSize:int = 21
@export var deck:Array[Card]
@export var discard:Array


func _ready() -> void:
	hp = maxHP
