extends Node2D

const cloud_template = preload("res://Cloud/Cloud.tscn")

func spawn():
	var new_cloud = cloud_template.instance()
	new_cloud.global_position=self.global_position
	get_parent().get_node("Clouds").add_child(new_cloud)
