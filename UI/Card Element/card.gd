extends Control
class_name CardElem

@export var card_res:Card

func fill_values():
	$VBoxContainer/Title.append_text(card_res.title)
	$"VBoxContainer/Card Art/Card Art".texture = card_res.texture
	$VBoxContainer/Description/ScrollContainer/Description.append_text(card_res.title)
