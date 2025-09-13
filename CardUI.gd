class_name CardUI extends Control

signal selected
signal deselected

@export var card_res:CardDataClass
@onready var texture_rect: TextureRect = $CardOffset/TextureRect
@onready var card_texture: TextureRect = $CardOffset/CardTexture
@onready var text: RichTextLabel = $CardOffset/Text
@onready var title: RichTextLabel = $CardOffset/Title
@onready var highlight: ColorRect = $CardOffset/Highlight
@onready var price_text:Label = $PanelContainer/Price

func _ready() -> void:
	highlight.visible = false
	focus_entered.connect(func():
		highlight.visible = true
		selected.emit()
		)
	
	focus_exited.connect(func():
		highlight.visible = false
		deselected.emit()
		)
	
	card_res.setUpCard()
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	title.text = card_res.title
	card_texture.texture = card_res.texture
	text.text = card_res.text
	price_text.text = str(card_res.price)

func _on_mouse_entered():
	#print("I %s have been entered"%[get_index()])
	pass

func _on_mouse_exited():
	#print("I %s have been exited"%[get_index()])
	pass
