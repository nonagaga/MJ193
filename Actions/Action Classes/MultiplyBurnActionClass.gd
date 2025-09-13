extends Action
class_name MultiplyBurnAction

@export var amount:float

func resolve(targets:Array[Enemy]):
	for i in targets:
		for x in i.burns:
			x.dmg = roundi(float(x.dmg)*amount)

func updateText():
	actualText =text%str(amount)
