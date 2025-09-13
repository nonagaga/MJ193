extends CanvasLayer

var cur_card_selected:Card = null
var card_packed = preload("res://card.tscn")
@export var hand : HBoxContainer

func _ready()->void:
	if Globals.gameManager:
		Globals.gameManager.card_drawn.connect(on_card_drawn)
		
	on_card_drawn(load("res://Cards/StabCard.tres"))

func on_card_drawn(card:Card):
	if card == null:
		return
	create_card(card).reparent(hand,false)

func create_card(card:Card)->Control:
	var new_card_instance = card_packed.instantiate()
	new_card_instance.card_res = card
	$Void.add_child(new_card_instance)
	return new_card_instance

func card_selected(item:Control):
	if cur_card_selected!=null:
		pass

func deselect_card(item:Control):
	pass

func _on_play_pressed() -> void:
	##remove it from hand
	pass # Replace with function body.


func _on_cancel_pressed() -> void:
	pass # Replace with function body.


func _on_end_turn_pressed() -> void:
	pass # Replace with function body.
