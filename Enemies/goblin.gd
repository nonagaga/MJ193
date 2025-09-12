extends Enemy


func attackTrigger():
	Player.health -= dmg
