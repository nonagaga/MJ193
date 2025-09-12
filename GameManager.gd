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
func _ready() -> void:
	Globals.gameManager = self

signal card_drawn(card:Card)
func draw():
	if !Globals.deck.is_empty():
		var card = Globals.deck.pop_front()
		Globals.hand.append(card)
		card_drawn.emit(card)
		return card

func discard():
	var card:Card
	Globals.discard.append(card)
	Globals.hand.erase(card)

func addCardToDeck(card):
	Globals.deck.append(card)
	
func removeCardFromDeck(card):
	Globals.deck.erase(card)
	card.die()

func destroyCard(card):
	card.die()

func playCard(card:Card):
	#check if the card requires you to discard cards before playing it
	if card.discardCost!= 0:
		#check if you have enough cards to discard to play the card
		if Globals.hand.size() >= card.discardCost:
			#discard the cards
			for i in range(card.discardCost):
				discard()
			#now play the card
			Globals.discard.append(card)
			Globals.hand.erase(card)
		else:
			#add can't play card function here
			pass
	#actually play the card here
	Globals.discard.append(card)
	Globals.hand.erase(card)
