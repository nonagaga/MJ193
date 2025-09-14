extends Node

signal card_drawn(card:CardDataClass)
signal can_play_card(y:bool)
enum GAME_STATE {WIN, LOSE, PLAYING}
var game_state : GAME_STATE = GAME_STATE.PLAYING
var maxTargets:int = 0
var enemy_list : Array[EnemyTwo]
var target_list : Array[EnemyTwo]
@export var enemy_packed:PackedScene = preload("res://UI/Enemy Element/Enemy.tscn")
@export var end_turn_button : Button
@export var enemies : Control
##this array only accepts enemy resource arrays, so a group of enemies will just be the sum of their parts
@export var enemy_options : Array[EnemyGroup] = []

func _ready() -> void:
	Globals.gameManager = self
	enemy_options.sort_custom(options_sort)
	start_game()

func options_sort(a:EnemyGroup,b:EnemyGroup):
	return a.points>b.points

func start_game() -> void:
	# figure out some way to read the enemies in a room
	#for enemy : Enemy in enemies.get_children():
		#enemy_list.append(enemy)
	point_buy_greed()
	# wait for the scene to fully transition over
	await Globals.scene_manager.transition_finished
	
	for enemy in enemy_list:
		enemy.entersTrigger()
		# wait a little between activating guys
		await get_tree().create_timer(0.5).timeout
	
	# this is the main game loop
	while game_state == GAME_STATE.PLAYING:
		await player_turn()
		for enemy : EnemyTwo in enemy_list:
			await enemy_turn(enemy)
			
func player_turn():
	for i in range(3 - Globals.hand.size()):
		print("drawing")
		draw()
	# play individual cards
	# player has finished turn
	await end_turn_button.pressed

func enemy_turn(enemy : EnemyTwo):
	await enemy.attackTrigger()
	check_player_death()

func point_buy_greed():
	Globals.cur_points = Globals.max_points
	var cur_group_indx : int = 0
	print(enemy_options)
	print(enemy_options[cur_group_indx])
	#these points are already sorted
	while Globals.cur_points>0:
		if enemy_options[cur_group_indx].points>Globals.cur_points or enemy_options[cur_group_indx].points < 1:#move forward through the array
			cur_group_indx+=1
		elif cur_group_indx>=enemy_options.size():
			break
		else:
			Globals.cur_points -= enemy_options[cur_group_indx].points
			#add enemy to enemy node
			for enemy_res:EnemyRes in enemy_options[cur_group_indx].enemy_reses:
				var new_enemy:EnemyTwo = create_enemy(enemy_res)
				adjust_add_child(new_enemy)
				enemy_list.append(new_enemy)
				new_enemy.i_died.connect(kill_enemy.bind(new_enemy))


func adjust_add_child(balls:EnemyTwo):
	#use this for custom placement logic for dynamic adding to the scene
	for spawn in get_tree().get_nodes_in_group("enemy_spawns"):
		if spawn.get_child_count() == 0:
			spawn.add_child(balls)
			return
			
	printerr("No available spawns left!")
	

func create_enemy(enemy_res:EnemyRes)->EnemyTwo:
	var new_enemy_instance : EnemyTwo = enemy_packed.instantiate()
	new_enemy_instance.enemy_res = enemy_res
	return new_enemy_instance

func kill_enemy(enemy:EnemyTwo):
	enemy_list.erase(enemy)
	enemy.queue_free()

func check_player_death():
	if Globals.hp <= 0:
		game_state = GAME_STATE.LOSE
		print("Game over!")

func draw():
	if !Globals.deck.is_empty():
		var card = Globals.deck.pop_front()
		card_drawn.emit(card)
		return card

func discard(card:CardDataClass):
	Globals.discard.append(card)
	Globals.hand.erase(card)
	card.discardEffect()

func addCardToDeck(card):
	Globals.deck.append(card)
	
func removeCardFromDeck(card):
	Globals.deck.erase(card)
	card.die()

func destroyCard(card):
	card.die()

func check_room_cleared():
	if enemy_list.size() == 0:
		game_state = GAME_STATE.WIN
