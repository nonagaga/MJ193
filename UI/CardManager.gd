class_name PlayerUI extends CanvasLayer

signal turn_completed

var selected_card:CardUI = null
var card_packed = preload("res://CardUI.tscn")
@onready var hand: HBoxContainer = $Hand
@onready var play: Button = $"Player Choices/Play"
@onready var cancel: Button = $"Player Choices/Cancel"
@onready var end_turn: Button = $"Player Choices/End Turn"

func _ready()->void:
	play.disabled = true
	cancel.disabled = true
	_setup_signals()

func create_card(card:CardDataClass)->Control:
	var new_card_instance = card_packed.instantiate()
	new_card_instance.card_res = card
	$Void.add_child(new_card_instance)
	return new_card_instance

func on_card_selected(card_ui:CardUI):
	selected_card = card_ui
	# toggles play button depending on validity of play
	play.disabled = false if selected_card.card_res.canPlayCard() == OK else true
	
func on_card_deselected(card_ui:CardUI):
	# not sure whether deselect is resolved before select.
	if selected_card == card_ui:
		selected_card = null
	
	play.disabled = true

func draw():
	if !Globals.deck.is_empty():
		var card = Globals.deck.pop_front()
		Globals.hand.append(card)
		var card_ui : CardUI = create_card(card)
		card_ui.reparent(hand, false)
		card_ui.scale = Vector2.ZERO
		card_ui.selected.connect(on_card_selected)
		card_ui.deselected.connect(on_card_deselected)
		
		await card_ui.animation_finished
	else:
		printerr("DRAW CARD FAILED: DECK IS EMPTY!")

func play_card(card_ui : CardUI):
	var card_res = card_ui.card_res
	card_res.playCard()

func discard():
	var card:CardDataClass
	Globals.discard.append(card)
	Globals.hand.erase(card)
	card.discardEffect()

func addCardToDeck(card):
	Globals.deck.append(card)
	
func removeCardFromDeck(card):
	Globals.deck.erase(card)
	card.die()

func destroyCard(card):
	card.die()
	
func _setup_signals():
	# use end turn button to emit when turn is completed
	end_turn.pressed.connect(func():
		turn_completed.emit()
		)
		
