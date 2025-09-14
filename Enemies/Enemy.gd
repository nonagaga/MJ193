extends TextureButton
class_name Enemy
@export var enemy_res:EnemyRes
@export var animation_player : AnimationPlayer
@export var target_highlight: TextureRect

var hp:int
var speed:int
var dmg:int
var frozen:int=0
var burns:Array[Burn]
var weakened:int = 0
var true_size:Vector2 = Vector2.ONE
const ENTEREXITLENGTH :float = 0.5

var turnTillAttack:int

func _ready() -> void:
	hp = enemy_res.maxHP
	speed = enemy_res.speed
	dmg = enemy_res.dmg
	texture_normal = enemy_res.skin
	add_to_group("Enemy")
	entersTrigger()

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
			turnTillAttack = enemy_res.maxTurnTillAttack
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
signal i_died()
func deathTrigger():
	var tween = create_tween()
	tween.tween_property(self,"scale",Vector2.ZERO,ENTEREXITLENGTH)
	i_died.emit()

#overwritable function for when an enemy spawns
func entersTrigger():
	if enemy_res.theme_song:
		MusicManager.add_next_measure(enemy_res.theme_song, enemy_res.theme_song_name)
	var tween = create_tween()
	tween.tween_property(self,"scale",true_size,ENTEREXITLENGTH)


func damaged(dmg:int):
	damagedTrigger()
	hp -= dmg

func _on_mouse_entered() -> void:
	print("On hover")
	if !pressed:
		target_highlight.modulate = Color(150,0,0,1)

func _on_mouse_exited() -> void:
	if !pressed:
		target_highlight.modulate = Color(255,255,255,1)

func _toggled(toggled_on:bool):
	if toggled_on:
		if Globals.gameManager.maxTargets > Globals.gameManager.target_list.size():
			target_highlight.modulate = Color(255,0,0,1)
			Globals.gameManager.target_list.append(self)
			Globals.gameManager.can_play_card.emit(true)
		else:
			self.button_pressed
	else:
		target_highlight.modulate = Color(255,255,255,1)
		Globals.gameManager.target_list.erase(self)
		if Globals.gameManager.target_list.size() == 0:
			Globals.gameManager.can_play_card.emit(false)
