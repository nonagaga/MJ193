extends PanelContainer

func _on_main_menu_pressed() -> void:
	Globals.scene_manager.transition_to("default")
