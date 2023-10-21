extends Control

func _on_Voltar_pressed():
	get_tree().change_scene("res://stages/HowToPlay.tscn")


func _on_Prximo_pressed():
	get_tree().change_scene("res://stages/HowToPlayGamepad.tscn")
	
