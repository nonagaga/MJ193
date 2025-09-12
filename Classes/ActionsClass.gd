extends Resource
class_name Action
@export var maxTargets:int
#function that is called when an action resolves
func resolve(targets:Array[Enemy]):
	print(get_class())
