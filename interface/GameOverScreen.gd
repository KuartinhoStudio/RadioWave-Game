extends Control

func _on_PlayerDeath():
	visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
func _on_JogarNovamenteButton_pressed():
	get_tree().reload_current_scene()

func _on_SairButton_pressed():
	get_tree().change_scene("res://stages/StartMenu.tscn")
