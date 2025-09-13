extends Action
class_name AddCardToDeck
@export var cardToAdd:CardDataClass

func resolve(targets:Array[Enemy]):
	Globals.deck.append(cardToAdd)
