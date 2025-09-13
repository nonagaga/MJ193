extends Action
class_name WeakenAction
@export var weakenStacks:int

func resolve(targets:Array[Enemy]):
	for i in targets:
		i.weakened+=weakenStacks

func updateText():
	actualText = text % str(weakenStacks)
