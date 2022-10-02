extends Node2D

var mobile : bool = true
var towns=[]

func _ready():
	GameState.prep_rand()
	towns=get_tree().get_nodes_in_group("towns")

