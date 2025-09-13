extends Action
class_name HealAction

@export var amount:int
func resolve(targets):
	Globals.hp += amount
	clamp(Globals.hp,0,Globals.maxHP)

func updateText():
	actualText =text%str(amount)
