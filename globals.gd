extends Node

signal health_updated(health)

@export var maxHP:int
var hp:int :
	set(val):
		hp = max(0,val)
		health_updated.emit(hp)
		
@export var maxDeckSize:int = 21
@export var deck:Array[CardDataClass]
@export var discard:Array[CardDataClass]
var money:int = 10000
var deck_increase_price:int = 40
const DECKINCREASEAMT:int = 3
var hand:Array[CardDataClass]
var scene_manager : SceneManager

func _ready() -> void:
	hp = maxHP
	scene_manager = get_tree().get_root().get_node("SceneManager")
	_debug_populate_deck()

func _debug_populate_deck() -> void:
	var card_dir_path = "res://Cards/"
	var card_dir = DirAccess.open(card_dir_path)
	if card_dir:
		card_dir.list_dir_begin()
		var file_name = card_dir.get_next()
		while file_name != "":
			deck.append(load(card_dir_path + file_name))
			file_name = card_dir.get_next()
		card_dir.list_dir_end() # Important: call this to clean up resources
