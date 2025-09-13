extends Action
class_name SelfDamageAction
@export var amount:int

func resolve(targets):
	Globals.hp -= amount
	Globals.gameManager.check_player_death()
	
func updateText():
	actualText = text % str(amount)
