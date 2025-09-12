extends Action
class_name DrawAction
@export var num:int

func resolve(targets:Array[Enemy]):
	var x = 0
	while x <num:
		if !Globals.deck.is_empty():
			Globals.hand.append(Globals.deck.pop_front())
			x+=1
