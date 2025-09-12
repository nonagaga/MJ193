extends Action
class_name AddCardToDeck
@export var cardToAdd:Card

func resolve(targets:Array[Enemy]):
	Globals.deck.append(cardToAdd)
