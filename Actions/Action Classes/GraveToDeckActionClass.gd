extends Action
class_name GraveToDeckAction
@export var amount:int

func resolve(targets):
	card.grave_to_deck.emit(amount)

func updateText():
	actualText =text%str(amount)
