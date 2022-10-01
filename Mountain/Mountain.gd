extends Node2D

const cloud_template = preload("res://Cloud/Cloud.tscn")

func _ready():
	spawn()

func spawn():
	var new_cloud = cloud_template.instance()
	new_cloud.global_position=self.global_position
	new_cloud.set_owner(self)
	get_parent().get_node("Clouds").add_child(new_cloud)


func im_dead():
	spawn()
