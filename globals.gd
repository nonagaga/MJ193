extends Node
@export var maxHP:int
var hp:int
@export var maxDeckSize:int = 21
@export var deck:Array[CardDataClass]
@export var discard:Array[CardDataClass]
var money:int = 10000
var deck_increase_price:int = 40
const DECKINCREASEAMT:int = 3
var hand:Array[CardDataClass]
var gameManager
var scene_manager : SceneManager

func _ready() -> void:
	hp = maxHP
	scene_manager = get_tree().get_root().get_node("SceneManager")
