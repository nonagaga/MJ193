extends Action
class_name GraveToHandAction
@export var amount:int

func resolve(targets):
	card.grave_to_hand.emit(amount)

func updateText():
	actualText =text%str(amount)
