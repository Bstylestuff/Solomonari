extends Node2D

const enemt_template = preload("res://Enemies/Enemy.tscn")
var towns=[]

var rng = RandomNumberGenerator.new()

func _ready():
	towns = get_tree().get_nodes_in_group("towns")
	rng.randomize()
	spawn()

func spawn():
	var new_enemy = enemt_template.instance()
	var target = get_target()
	new_enemy.set_owner(self)
	new_enemy.set_target(target)
	new_enemy.global_position=self.global_position
	get_parent().get_node("enemy").add_child(new_enemy)

func get_target():
	var random_target = rng.randi_range(0,towns.size()-1)
	return towns[random_target].global_position

func i_died():
	spawn()
	pass
