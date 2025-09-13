extends Action
class_name DrawAction
@export var drawNum:int

func resolve(targets:Array[Enemy]):
	for i in range(drawNum):
		card.draw.emit(drawNum)

func updateText():
	actualText = text % str(drawNum)
