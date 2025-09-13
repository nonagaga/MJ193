@tool
extends HBoxContainer

@export var default_x_pos = 240.0
@export var default_num_cards = 3
@export var anim_speed = 50
@onready var default_scale = scale

func _ready() -> void:
	_auto_resize()
	child_entered_tree.connect(func(_child):
		_auto_resize()
		)
	child_exiting_tree.connect(func(_child):
		await get_tree().process_frame
		_auto_resize()
		)
	
func _auto_resize():
	var num_cards = get_child_count()
	var card_ratio = float(num_cards) / float(default_num_cards)
	if card_ratio > 1:
		create_tween().set_trans(Tween.TRANS_CUBIC).tween_property(self, "scale", default_scale / card_ratio, 0.5)
	else:
		create_tween().set_trans(Tween.TRANS_CUBIC).tween_property(self, "scale", default_scale, 0.5)
	
