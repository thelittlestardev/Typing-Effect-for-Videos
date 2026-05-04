extends Control

func _ready() -> void:
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)

func _on_start_button_down() -> void:
	var my_text: String = $LineEdit.text
	if my_text != "":
		var adjusted_text: String = my_text.replace("\\", "\n")
		Global.phrase = adjusted_text
	else:
		Global.phrase = "TYPING\nEFFECT\nFOR VIDEOS"
	get_tree().change_scene_to_file("res://scenes/typing.tscn")
