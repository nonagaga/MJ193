extends DrawAction
@export var discNum:int

func resolve(targets:Array[Enemy]):
	for i in range(drawNum):
		await Globals.GameManager.draw()
	for i in range(discNum):
		await Globals.GameManager.discard()
