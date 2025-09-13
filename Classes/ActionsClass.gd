extends Resource
class_name Action
@export var maxTargets:int
@export var doesTarget:bool
@export var text:String
var actualText:String
var card:CardDataClass
#function that is called when an action resolves
func resolve(targets:Array[Enemy]):
	print(get_class())

func updateText():
	actualText = text
