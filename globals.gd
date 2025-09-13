extends Node
@export var maxHP:int
var hp:int
@export var maxDeckSize:int = 21
@export var deck:Array[CardDataClass]
@export var discard:Array[CardDataClass]
var money:int = 0
var hand:Array[CardDataClass]
var gameManager
var scene_manager : SceneManager

func _ready() -> void:
	hp = maxHP
	scene_manager = get_tree().get_root().get_node("SceneManager")
