extends Card


func playEffect():
	for i in targets:
		i.damaged(5)
