extends Control

var backing_track = preload("res://Music Manager/Backing Track.mp3")

func _ready() -> void:
	MusicManager.load_song(110, 4, backing_track)
	MusicManager.start_song()

func start():
	Globals.scene_manager.transition_to("game","default")


func _on_credits_pressed() -> void:
	$Credits.show()


func _on_options_pressed() -> void:
	$Options.show()
