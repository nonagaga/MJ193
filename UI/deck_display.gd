extends Control

@export var remove_button:Button
@onready var card_ui_packed:PackedScene = preload("res://card.tscn")
const REMOVEPRICE:int = 40
var current_sel : CardUI = null:
	set(val):
		if current_sel == val:
			return
		current_sel = val
		remove_button.disabled = current_sel==null or REMOVEPRICE>Globals.money

var displayed_cards:Array[CardUI] = []
@export var grid_cont:GridContainer

func _ready()->void:
	remove_button.text = "Remove Card (%s moners)"%[REMOVEPRICE]
	display_deck()

func display_deck():
	for child:Control in grid_cont.get_children():
		child.queue_free()
	#fill the display and array
	for card:CardDataClass in Globals.deck:
		var cur_ui:CardUI = create_card_UI(card)
		displayed_cards.append(cur_ui)
		cur_ui.reparent(grid_cont)

func remove():
	var index:int = displayed_cards.find(current_sel)
	if index>=0:
		displayed_cards[index].queue_free()
		Globals.deck.erase(Globals.deck[index])
		displayed_cards.erase(displayed_cards[index])
		current_sel = null
		Globals.money-= REMOVEPRICE
		remove_button.text = "Remove Card (%s moners)"%[REMOVEPRICE]

func create_card_UI(card_data:CardDataClass)->CardUI:
	var new_card_instance : CardUI = card_ui_packed.instantiate()
	new_card_instance.card_res = card_data
	$Void.add_child(new_card_instance)
	new_card_instance.selected.connect(card_selected.bind(new_card_instance))
	return new_card_instance

func card_selected(ui:CardUI):
	current_sel = ui
	pass

func close():
	visible = false
