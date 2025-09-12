extends Node

enum GAME_STATE {WIN, LOSE, PLAYING}
var game_state : GAME_STATE = GAME_STATE.PLAYING
var enemy_list : Array[Enemy]
@export var end_turn_button : Button

func start_game() -> void:
	# figure out some way to read the enemies in a room
	# enemy_list.append(each_enemy)
	while game_state == GAME_STATE.PLAYING:
		player_turn()
		for enemy : Enemy in enemy_list:
			enemy_turn(enemy)
			
func player_turn():
	for i in range(3 - Globals.hand.size()):
		draw_card()
	
	# play individual cards
	# player has finished turn
	await end_turn_button.pressed

func enemy_turn(enemy : Enemy):
	enemy.attackTrigger()

func draw_card():
	pass
