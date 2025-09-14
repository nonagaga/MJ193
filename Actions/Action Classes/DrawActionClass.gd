extends Action
class_name DrawAction
@export var drawNum:int

func resolve(targets:Array[Enemy]):
	for i in range(drawNum):
		Globals.gameManager.draw()

func updateText():
	actualText = text % str(drawNum)
