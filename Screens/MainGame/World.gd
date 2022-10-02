extends Node2D

var mobile : bool = true
var total_towns=0
var dead_towns=0
var angry_towns=0
var abandoned_towns=0

var amount

export var townList=[]

signal death
signal angry
signal abandoned
signal notAngry


func _ready():
	GameState.prep_rand()
	townList=get_tree().get_nodes_in_group("towns")
	total_towns=townList.size()

func _townDied():
	dead_towns+=1
	_remove_town()
	_eval_towns()

func _townAngry():
	angry_towns+=1
	_eval_towns()

func _townAbandoned():
	abandoned_towns+=1
	_remove_town()
	_eval_towns()

func _townNotAngry():
	angry_towns-=1
	_eval_towns()

func _eval_towns():
	if(dead_towns+abandoned_towns+angry_towns>=total_towns):
		_game_over()

func _remove_town():
	print("removing")
	for town in townList:
		if(!town.functional()):
			townList.remove(townList.find(town))

func _game_over():
	pass
