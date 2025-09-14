extends TextureButton
class_name Enemy
@export var maxHP:int
@export var hp:int
@export var speed:int
@export var dmg:int
#how expensive is the enemy for our algorithm to spawn
@export var points:int
@export var animation_player : AnimationPlayer
@export var theme_song : AudioStream
@export var theme_song_name : String
@export var target_highlight: TextureRect
var frozen:int=0
var burns:Array[Burn]
var weakened:int = 0
@export var maxTurnTillAttack:int
var turnTillAttack:int

func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	toggled.connect(_toggled)
	add_to_group("Enemy")
	# advance to the very first frame of the enter animation
	animation_player.play("enter")
	animation_player.advance(0)
	animation_player.pause()

#handle burn debuff
func burn():
	var burnDamage = 0
	for i in burns:
			burnDamage += i.dmg
			i.rounds -=1
			if i.rounds<1:
				burns.erase(i)
	damaged(burnDamage)

#overwritable function for when an enemy attacks
func attackTrigger():
	burn()
	if frozen<1:
		if turnTillAttack == 0:
			turnTillAttack = maxTurnTillAttack
			if weakened >0:
				Globals.hp -= dmg/2
			else:
				Globals.hp -= dmg
			if animation_player:
				animation_player.play("attack")
				await animation_player.animation_finished
		else: 
			turnTillAttack -= 1
	else:frozen-=1

#overwritable function for when an enemy is damaged
func damagedTrigger():
	if animation_player:
		animation_player.play("damaged")
		await animation_player.animation_finished

#overwritable function for when an enemy dies
func deathTrigger():
	if animation_player:
		animation_player.play("death")
		await animation_player.animation_finished

#overwritable function for when an enemy spawns
func entersTrigger():
	if theme_song:
		MusicManager.add_next_measure(theme_song, theme_song_name)
	if animation_player:
		animation_player.play("enter")


func damaged(dmg:int):
	damagedTrigger()
	hp -= dmg

func _on_mouse_entered() -> void:
	if !pressed:
		target_highlight.modulate = Color(150,0,0,1)

func _on_mouse_exited() -> void:
	if !pressed:
		target_highlight.modulate = Color(255,255,255,1)

func _toggled(toggled_on:bool):
	if toggled_on:
		target_highlight.modulate = Color(255,0,0,1)
		Globals.gameManager.target_list.append(self)
	else:
		target_highlight.modulate = Color(255,255,255,1)
		Globals.gameManager.target_list.erase(self)
