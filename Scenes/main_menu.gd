extends Node2D

var backing_track = preload("res://Music Manager/Backing Track.mp3")

func _ready() -> void:
	MusicManager.load_song(110, 4, backing_track)
	MusicManager.start_song()
