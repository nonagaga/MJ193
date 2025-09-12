extends Node

func _ready() -> void:
	Globals.gameManager = self

signal card_drawn(card:Card)
func draw():
	if !Globals.deck.is_empty():
		var card = Globals.deck.pop_front()
		Globals.hand.append(card)
		card_drawn.emit(card)
		return card

func discard():
	var card:Card
	Globals.discard.append(card)
	Globals.hand.erase(card)
