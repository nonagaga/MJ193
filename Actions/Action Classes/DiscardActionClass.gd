extends Action
class_name DiscardAction
@export var discNum:int

func resolve(targets:Array[Enemy]):
	for i in range(discNum):
		await Globals.GameManager.discard()

func updateText():
	actualText = text % str(discNum)
