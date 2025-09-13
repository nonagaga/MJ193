extends Control

const BUYABLECOUNT:int = 3
@export var shop_deck : Array[CardDataClass]
var buy_slots : Dictionary[CardUI,CardDataClass]
@onready var card_ui_packed:PackedScene = preload("res://card.tscn")
@export var buy_button:Button 
var current_sel : CardUI = null:
	set(val):
		if current_sel == val:
			return
		current_sel = val
		buy_button.disabled = current_sel==null

func _ready():
	current_sel = null
	#reshuffle graveyard into deck
	while !Globals.discard.is_empty():
		Globals.deck.append(Globals.discard.pop_front())
	fill_shop()

func buy_selected():
	_on_card_buy(current_sel)

func card_selected(ui:CardUI):
	#print(ui)
	#print(ui.card_res)
	#print(ui.card_res.price)
	if ui.card_res.price<=Globals.money:
		current_sel = ui
	else:
		current_sel = null
		not_enough_money()

func _on_card_buy(ui:CardUI):
	current_sel = null
	Globals.deck.append(buy_slots[ui])
	buy_slots.erase(ui)
	ui.queue_free()
	card_bought()
	add_new_card()

func fill_shop():
	while $HBoxContainer.get_child_count()<BUYABLECOUNT:
		add_new_card()

func add_new_card():
	var new_card:CardUI = create_card_UI(shop_deck.pick_random())
	new_card.reparent($HBoxContainer)
	buy_slots[new_card] = new_card.card_res

func create_card_UI(card_data:CardDataClass):
	var new_card_instance : CardUI = card_ui_packed.instantiate()
	new_card_instance.card_res = card_data
	$Void.add_child(new_card_instance)
	new_card_instance.price_text.get_parent().visible = true
	new_card_instance.selected.connect(card_selected.bind(new_card_instance))
	new_card_instance.custom_minimum_size.x = 500
	return new_card_instance

func card_bought():
	$PanelContainer/RichTextLabel.text = "Thank you for your purchase"

func not_enough_money():
	$PanelContainer/RichTextLabel.text = "Uh you need more cash for that."


func _on_quit_pressed() -> void:
	Globals.scene_manager.transition_to("game")
