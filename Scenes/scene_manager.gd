class_name SceneManager extends Node

signal scene_changed(scene_name : String)
signal transition_finished()

@export var scene_list : Dictionary[String, PackedScene]
@export var trans_list : Dictionary[String, PackedScene]
var current_scene : Node
var current_transition : Node

func _ready() -> void:
	var packed_scene = scene_list.get("default") as PackedScene
	if not packed_scene:
		printerr("NO DEFAULT SCENE PROVIDED IN SCENE LIST")
		return

	current_scene = packed_scene.instantiate()
	add_child(current_scene)

func transition_to(scene_name : String, transition_name : String = "default") -> void:
	var transition_scene = trans_list.get(transition_name) as PackedScene
	
	# load transition
	if not transition_scene:
		printerr("NO DEFAULT TRANSITION PROVIDED IN TRANSITION LIST")
		return
	
	var transition_instance = transition_scene.instantiate() as SceneTransition
	
	# make sure transition is always over loaded scene
	add_child(transition_instance)
	transition_instance.transition_in()
	await transition_instance.transitioned_in
	
	# remove old scene
	current_scene.queue_free()
	
	# load new scene
	var new_scene = scene_list.get(scene_name) as PackedScene
	
	if not new_scene:
		printerr("SCENE NAME: %s NOT FOUND IN SCENE LIST" % scene_name)
		return
		
	current_scene = new_scene.instantiate()
	add_child(current_scene)
	scene_changed.emit(scene_name)
	
	transition_instance.transition_out()
	await transition_instance.transitioned_out
	transition_instance.queue_free()
	transition_finished.emit()
