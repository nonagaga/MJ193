extends Action
class_name DamageAction
@export var damage:int


func resolve(targets:Array[Enemy]):
	for i:Enemy in targets:
		i.damaged(damage)
