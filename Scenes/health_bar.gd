extends TextureProgressBar

func _ready() -> void:
	max_value = Globals.maxHP
	Globals.health_changed.connect(func(new_health):
		value = new_health
		)
