extends Resource
class_name Tag
@export var title:String
@export var text:String
@export var texture:Texture2D

func resolve():
	print(title)

func removed():
	print("removed "+ str(title))
