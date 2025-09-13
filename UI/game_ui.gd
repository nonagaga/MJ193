extends Control

var cur_card_selected:CardElem = null
var card_packed:PackedScene = preload("res://UI/ Element/.tscn")

@export var hand : HBoxContainer

func _ready()->void:
	if Globals.gameManager:
		Globals.gameManager.card_drawn.connect(on_card_drawn)
	
	on_card_drawn(load("res://Cards/StabCard.tres"))

func on_card_drawn(card:CardDataClass):
	if card == null:
		return
	create_card(card).reparent(hand,false)

func create_card(card:CardDataClass)->CardElem:
	var new_card_instance:CardElem = card_packed.instantiate()
	new_card_instance.card_res = card
	$Void.add_child(new_card_instance)
	new_card_instance.fill_values()
	return new_card_instance

func card_selected(item:CardElem):
	if cur_card_selected!=null:
		pass

func deselect_card(item:CardElem):
	pass

func _on_play_pressed() -> void:
	##remove it from hand
	pass # Replace with function body.


func _on_cancel_pressed() -> void:
	pass # Replace with function body.


func _on_end_turn_pressed() -> void:
	pass # Replace with function body.
