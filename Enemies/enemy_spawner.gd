extends Node2D

const enemt_template = preload("res://Enemies/Enemy.tscn")
var loaded_resource=null
var towns=[]
export (String, "turk","mag","tatar","rus") var enemy_id
var enemy_data = {"turk": {"img":"res://Enemies/Enemy1/Art/Visual/turk.png", "speed":120, "hp":5}, "mag": {"img":"res://Enemies/Enemy1/Art/Visual/mag.png", "speed":80, "hp":7}, "tatar": {"img":"res://Enemies/Enemy1/Art/Visual/tatar.png", "speed":160, "hp":3} , "rus": {"img":"res://Enemies/Enemy1/Art/Visual/rus.png", "speed":90, "hp":10}}

func _ready():
	if(GameState.randomizer==null):
		GameState.prep_rand()
	var targ_res= enemy_data[enemy_id]
	loaded_resource = load(enemy_data[enemy_id]["img"])
	towns = get_tree().get_nodes_in_group("towns")
	spawn()

func spawn():
	var new_enemy = enemt_template.instance()
	#var target = 
	new_enemy.set_owner(self)
	print(towns)
	new_enemy.set_speed(enemy_data[enemy_id]["speed"])
	new_enemy.set_hp(enemy_data[enemy_id]["hp"])
	new_enemy.set_image(loaded_resource)
	new_enemy.set_target(get_target())
	new_enemy.global_position=self.global_position
	get_parent().get_node("enemy").add_child(new_enemy)

func get_target():
	
	var random_target = GameState.randomizer.randi_range(0,towns.size()-1)
	return towns[random_target].global_position

func i_died():
	$Timer.set_wait_time(GameState.randomizer.randi_range(10,25))
	$Timer.start(0)
	pass


func _on_Timer_timeout():
	$Timer.stop()
	spawn()
	pass # Replace with function body.
