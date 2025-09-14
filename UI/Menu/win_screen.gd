extends PanelContainer


func _on_double_pressed() -> void:
	Globals.scene_manager.transition_to("game")


func _on_nothing_pressed() -> void:
	Globals.scene_manager.transition_to("shop")
