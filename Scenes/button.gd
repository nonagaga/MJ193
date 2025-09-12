extends Button

func _ready() -> void:
	pressed.connect(func():
		Globals.scene_manager.transition_to("game")
		)
