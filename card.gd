extends Control
@export var cardRes:CardDataClass
@onready var card_texture: TextureRect = $CardTexture
@onready var rich_text_label: RichTextLabel = $RichTextLabel

func _ready() -> void:
	cardRes.compileCardText()
	rich_text_label.text = cardRes.text
	cardRes.drawEffect()
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	
func _on_mouse_entered():
	scale *= 2

func _on_mouse_exited():
	scale /= 2
