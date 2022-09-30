extends Node

func _on_StartButton_pressed():
	MapChanger.goto_scene("res://Screens/MainGame/World.tscn")

func _on_Options_pressed():
	MapChanger.goto_scene("res://Screens/Menus/Options/Options.tscn")

func _on_Credits_pressed():
	MapChanger.goto_scene("res://Screens/Menus/Credits/Credits.tscn")

func _on_Quit_pressed():
	get_tree().quit()
