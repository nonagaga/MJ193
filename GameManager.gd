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

func addCardToDeck(card):
	Globals.deck.append(card)
	
func removeCardFromDeck(card):
	Globals.deck.erase(card)
	card.die()

func destroyCard(card):
	card.die()

func playCard(card:Card):
	#check if the card requires you to discard cards before playing it
	if card.discardCost!= 0:
		#check if you have enough cards to discard to play the card
		if Globals.hand.size() >= card.discardCost:
			#discard the cards
			for i in range(card.discardCost):
				discard()
			#now play the card
			Globals.discard.append(card)
			Globals.hand.erase(card)
		else:
			#add can't play card function here
			pass
	#actually play the card here
	Globals.discard.append(card)
	Globals.hand.erase(card)
