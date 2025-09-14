extends Node

signal card_drawn(card:CardDataClass)
signal can_play_card(y:bool)
enum GAME_STATE {WIN, LOSE, PLAYING}
var game_state : GAME_STATE = GAME_STATE.PLAYING
var enemy_list : Array[Enemy]
var target_list : Array[Enemy]
var maxTargets:int = 0
@export var end_turn_button : Button
@export var enemies : Node2D

func _ready() -> void:
	Globals.gameManager = self
	start_game()

func start_game() -> void:
	# figure out some way to read the enemies in a room
	for enemy : Enemy in enemies.get_children():
		enemy_list.append(enemy)
	# wait for the scene to fully transition over
	await Globals.scene_manager.transition_finished
	for enemy in enemy_list:
		enemy.entersTrigger()
		# wait a little between activating guys
		await get_tree().create_timer(0.5).timeout
	
	# this is the main game loop
	while game_state == GAME_STATE.PLAYING:
		await player_turn()
		for enemy : Enemy in enemy_list:
			await enemy_turn(enemy)
			
func player_turn():
	for i in range(3 - Globals.hand.size()):
		print("drawing")
		draw()
	# play individual cards
	# player has finished turn
	await end_turn_button.pressed

func enemy_turn(enemy : Enemy):
	await enemy.attackTrigger()
	check_player_death()

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
