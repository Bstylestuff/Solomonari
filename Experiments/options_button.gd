extends OptionButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func _on_options_button_pressed():
	MapChanger.goto_scene("res://Screens/Menus/Options/Options.tscn")
	pass # Replace with function body.

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass