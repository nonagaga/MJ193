extends Action
class_name FreezeAction
@export var duration:int

func resolve(targets:Array[Enemy]):
	for i in targets:
		if i.burns.is_empty():
			i.frozen += duration
		else:
			for x:Burn in i.burns:
				var burnDam = x.dmg
				x.dmg -= duration
				if x.dmg<1:
					i.erase(x)
					x.queue_free()
				duration -=burnDam
				if duration <1:
					break
				else:
					i.frozen+=duration

func updateText():
	actualText = text % str(duration)
