extends Action
class_name DiscardAction
@export var discNum:int

func resolve(targets:Array[Enemy]):
	for i in range(discNum):
		card.normal_discard.emit(discNum)

func updateText():
	actualText = text % str(discNum)
