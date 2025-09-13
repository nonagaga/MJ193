extends Control
@export var cardRes:CardDataClass

@export var card_res:Card
@onready var texture_rect: TextureRect = $CardOffset/TextureRect
@onready var card_texture: TextureRect = $CardOffset/CardTexture
@onready var text: RichTextLabel = $CardOffset/Text
@onready var title: RichTextLabel = $CardOffset/Title


func _ready() -> void:
	card_res.setUpCard()
	card_res.drawEffect()
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	title.text = card_res.title
	card_texture.texture = card_res.texture
	text.text = card_res.text
	
func _on_mouse_entered():
	pass

func _on_mouse_exited():
	pass
