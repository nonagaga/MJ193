extends CanvasLayer

@onready var fill_color: ColorRect = $FillColor
@onready var colors: TextureRect = $Colors
@onready var lines: TextureRect = $Lines
@onready var posters: Control = $Posters

func _ready() -> void:
	for child : Control in posters.get_children():
		if randf() > 0.5:
			child.visible = false

func random_color() -> Color:
	return Color(randf(), randf(), randf())
