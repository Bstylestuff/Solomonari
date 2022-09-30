extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const Cloud = preload("res://Cloud/Cloud.gd")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
# generates a new Cloud class. 
func _process(delta):
		if(fmod(delta,2) ==1):
			return Cloud.new()
		pass
