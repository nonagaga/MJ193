extends Control

var cur_card_selected:CardElem = null
var card_packed:PackedScene = preload("res://UI/Card Element/Card.tscn")

func on_card_drawn(card:Card):
	if card == null:
		return
	create_card(card).reparent($ScrollContainer/Hand,false)

func create_card(card:Card)->CardElem:
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
