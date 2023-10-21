extends Control

func _ready():
	Input.connect("joy_connection_changed", self, "_on_joy_connection_changed")

func _on_joy_connection_changed(device_id, connected):
	if connected:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
func _on_StartButton_pressed():
	get_tree().change_scene("res://scenes/cutscenes/Cutscene1.tscn")

func _on_HowToPlayButton_pressed():
	get_tree().change_scene("res://stages/HowToPlay.tscn")

func _on_QuitButton_pressed():
	get_tree().quit()
