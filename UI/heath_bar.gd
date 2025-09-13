extends ProgressBar

func _ready() -> void:
	Globals.health_updated.connect(func(health):
		value = health
		)
