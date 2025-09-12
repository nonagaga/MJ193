extends Node
@export var maxHP:int
var hp:int
@export var maxDeckSize:int = 21
@export var deck:Array[Card]
@export var discard:Array
var hand:Array[Card]

@onready var scene_manager = get_tree().get_root().get_node("SceneManager")

func _ready() -> void:
	hp = maxHP
