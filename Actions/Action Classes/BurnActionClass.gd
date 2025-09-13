extends Action
class_name BurnAction
@export var burnStacks:int

func resolve(targets:Array[Enemy]):
	for i in targets:
		if i.frozen != 0:
			burn(i)
		else:
			var freeze = i.frozen
			i.frozen-=burnStacks
			burnStacks -= freeze
			clamp(i.frozen,0,100)
			if burnStacks >0:
				burn(i)

func burn(target):
	var burn = Burn.new()
	burn.dmg = burnStacks
	burn.duration = 3
	target.burns.append(burn)

func updateText():
	actualText = text % str(burnStacks)
