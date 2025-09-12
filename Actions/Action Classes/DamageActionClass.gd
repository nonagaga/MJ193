extends Action
class_name DamageAction
@export var damage:int
var text = "Deal [b]" + str(damage) + " damage[/b] to target enemy. "

func resolve(targets:Array[Enemy]):
	for i:Enemy in targets:
		i.damaged(damage)
