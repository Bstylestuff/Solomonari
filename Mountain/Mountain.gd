extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const cloud_class = preload("res://Cloud/Cloud.gd")
const cloud_template = preload("res://Cloud/Cloud.tscn")
const cloud_texture = preload("res://Cloud/PngItem_2504867.png")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
# generates a new Cloud class. 
func _process(delta):
	if(fmod(delta,2) ==1):
		var new_cloud = cloud_template.instance()
		new_cloud.setup(cloud_texture)
		new_cloud.set_pos(Vector2(delta*100,delta*100))
		get_tree().get_root().add_child(new_cloud)


