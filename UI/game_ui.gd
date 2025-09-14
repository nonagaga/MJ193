extends CanvasLayer

var cur_card_selected:CardDataClass = null
var cur_card_ui:CardUI
var card_packed = preload("res://card.tscn")
@export var hand : HBoxContainer
var targeting:bool = false
var discarding:bool = false
var discardList:Array = []
var maxDiscards:int = 0
var minDiscards:int = 0
var discardCard:CardUI
@onready var play: Button = $"Player Choices/Play"
@onready var cancel: Button = $"Player Choices/Cancel"
@onready var end_turn: Button = $"Player Choices/End Turn"
@onready var discard = $"Player Choices/Discard"

func _ready()->void:
	await get_tree().process_frame
	play.disabled = true
	cancel.disabled = true
	if Globals.gameManager:
		Globals.gameManager.card_drawn.connect(on_card_drawn)
	if Globals.gameManager:
		Globals.gameManager.can_play_card.connect(minimumCardsTargetted)
	print(Globals.hand)

func on_card_drawn(card:CardDataClass):
	if card == null:
		return
	create_card(card).reparent(hand,false)

func create_card(card:CardDataClass)->Control:
	var new_card_instance = card_packed.instantiate()
	new_card_instance.card_res = card.duplicate()
	$Void.add_child(new_card_instance)
	new_card_instance.selected.connect(card_selected.bind(new_card_instance))
	Globals.hand.append(new_card_instance.card_res)
	new_card_instance.card_res.drawEffect
	return new_card_instance

func enter_discard_mode(cost:bool):
	end_turn.disabled = true
	if cost:
		minDiscards = cur_card_selected.discardCost
		discarding = true
		play.visible = false
		discard.visible = true
		cancel.disabled = false
	else:
		discardCard = cur_card_ui
		if maxDiscards > Globals.hand.size():
			minDiscards = Globals.hand.size()
		discarding = true
		discard.visible = true

func exit_discard_mode():
	end_turn.disabled = false
	discardList.clear()
	minDiscards = 0
	maxDiscards = 0
	discarding = false
	play.visible = true
	discard.visible = false
	discard.disabled = true

func enter_target_mode():
	end_turn.disabled = true
	Globals.gameManager.target_list.clear()
	Globals.gameManager.maxTargets = cur_card_selected.maxTargets
	targeting = true
	for i in get_tree().get_nodes_in_group("Enemy"):
		i.disabled = false
		i.target_highlight.visible = true

func exit_target_mode():
	end_turn.disabled = false
	Globals.gameManager.target_list.clear()
	Globals.gameManager.maxTargets = 0
	targeting = false
	for i in get_tree().get_nodes_in_group("Enemy"):
		if i.is_pressed():
			i._toggled(false)
		i.disabled = true
		i.target_highlight.visible = false
	disable_play()
		

func enable_play():
	play.disabled = false
	cancel.disabled = false

func disable_play():
	play.disabled = true
	cancel.disabled = true

func minimumCardsTargetted(y):
	if y:
		enable_play()
	else:
		disable_play()

func card_selected(item:Control):
	if !discarding:
		if !targeting:
			cur_card_ui = item
			cur_card_selected = item.card_res
			if cur_card_selected!=null:
				if cur_card_selected.canPlayCard():
					if cur_card_selected.doesCardTarget():
						enter_target_mode()
					else:
						enable_play()
				else:
					enable_play()
	else:
		cur_card_ui = item
		cur_card_selected = item.card_res
		if minDiscards >0:
			if !discardList.has(cur_card_ui) && discardList.size()<minDiscards:
				discardList.append(cur_card_ui)
				if discardList.size() == minDiscards:
					discard.disabled = false
			elif discardList.has(cur_card_ui):
				discardList.erase(cur_card_ui)
				if discardList.size() < minDiscards:
					discard.disabled = true
		else:
			if !discardList.has(cur_card_ui) && discardList.size()<maxDiscards && cur_card_ui!= discardCard:
				discardList.append(cur_card_ui)
				if discardList.size() == minDiscards:
					discard.disabled = false
			elif discardList.has(cur_card_ui):
				discardList.erase(cur_card_ui)
				if discardList.size() < minDiscards:
					discard.disabled = true

func deselect_card(item:Control):
	pass

func _on_play_pressed() -> void:
	if cur_card_selected.discardCost == 0:
		cur_card_selected.targets = Globals.gameManager.target_list
		await cur_card_selected.playCard()
		cur_card_ui.queue_free()
		exit_target_mode()
	else:
		enter_discard_mode(true)
	if discardList:
		pass


func _on_cancel_pressed() -> void:
	disable_play()
	if targeting:
		exit_target_mode()
	if discarding:
		exit_discard_mode()


func _on_end_turn_pressed() -> void:
	exit_target_mode()
	disable_play()
	pass # Replace with function body.


func _on_discard_pressed() -> void:
	exit_discard_mode()
