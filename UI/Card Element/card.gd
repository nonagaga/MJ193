extends Control
class_name CardElem

@export var card_res:CardDataClass

@export var art:TextureRect
@export var title:RichTextLabel
@export var desc:RichTextLabel

func fill_values():
	card_res.compileCardText()
	print(card_res)
	print(card_res.title)
	print(card_res.text)
	title.append_text(card_res.title)
	art.texture = card_res.texture
	desc.append_text(card_res.text)
