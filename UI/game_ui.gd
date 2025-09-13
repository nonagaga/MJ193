extends CanvasLayer

var cur_card_selected:CardDataClass = null
var card_packed = preload("res://card.tscn")
@export var hand : HBoxContainer
@onready var play: Button = $"Player Choices/Play"
@onready var cancel: Button = $"Player Choices/Cancel"
@onready var end_turn: Button = $"Player Choices/End Turn"

func _ready()->void:
	play.disabled = true
	cancel.disabled = true
	
	if Globals.gameManager:
		Globals.gameManager.card_drawn.connect(on_card_drawn)

func on_card_drawn(card:CardDataClass):
	if card == null:
		return
	create_card(card).reparent(hand,false)

func create_card(card:CardDataClass)->Control:
	var new_card_instance = card_packed.instantiate()
	new_card_instance.card_res = card.duplicate()
	$Void.add_child(new_card_instance)
	return new_card_instance

func enter_target_mode():
	for i in get_tree().get_nodes_in_group("Enemy"):
		i.enabled = true
		i.target_highlight.visible = true

func card_selected(item:Control):
	print("yipee")
	if cur_card_selected!=null:
		if cur_card_selected.doesCardTarget():
			enter_target_mode()

func deselect_card(item:Control):
	pass

func _on_play_pressed() -> void:
	cur_card_selected.playCard()
	pass # Replace with function body.


func _on_cancel_pressed() -> void:
	pass # Replace with function body.


func _on_end_turn_pressed() -> void:
	pass # Replace with function body.
