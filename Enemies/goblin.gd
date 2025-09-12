extends Enemy

func attackTrigger():
	super.attackTrigger()
	Globals.health -= dmg
