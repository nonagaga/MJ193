class_name SceneTransition extends CanvasLayer

signal transitioned_in
signal transitioned_out

@export var animation_player : AnimationPlayer

func transition_in():
	animation_player.play("in")
	await animation_player.animation_finished
	transitioned_in.emit()
	
func transition_out():
	animation_player.play("out")
	await animation_player.animation_finished
	transitioned_out.emit()
