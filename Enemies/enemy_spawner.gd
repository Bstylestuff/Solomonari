extends Node2D

const enemt_template = preload("res://Enemies/Enemy.tscn")
var towns=[]

var rng = RandomNumberGenerator.new()



func _ready():
	var towns = get_tree().get_nodes_in_group("towns")
	rng.randomize()
	print(towns[3])

func _process(delta):
	spawn()
	pass

func spawn():
	var new_enemy = enemt_template.instance()
	new_enemy.set_target(_get_target())
	new_enemy.global_position=self.global_position
	get_parent().add_child(new_enemy)
	

func _get_target():
	var random_target = rng.randi_range(0,towns.size()-1)
	print_debug (random_target)
	return Vector2 (200,200)

func i_died():
	spawn()
	pass
