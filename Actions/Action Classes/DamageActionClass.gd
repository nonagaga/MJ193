extends Action
class_name DamageAction
@export var damage:int
var text = "Deal [b]" + str(damage) + " damage[/b] to " + str(maxTargets) + " target enemy. "

func resolve(targets:Array[Enemy]):
	for i:Enemy in targets:
		i.damaged(damage)
