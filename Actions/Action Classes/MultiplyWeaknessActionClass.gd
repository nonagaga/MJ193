extends Action
class_name MultiplyWeaknessAction
@export var amount:float

func resolve(targets:Array[Enemy]):
	for i in targets:
		i.weakened = roundi(float(i.weakened) * amount)

func updateText():
	actualText =text%str(amount)
