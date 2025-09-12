extends Node

func _ready() -> void:
	Globals.gameManager = self

func draw():
	if !Globals.deck.is_empty():
		var card = Globals.deck.pop_front()
		Globals.hand.append(card)
		return card

func discard():
	var card:Card
	Globals.discard.append(card)
	Globals.hand.erase(card)
