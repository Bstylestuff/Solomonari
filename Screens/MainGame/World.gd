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

func get_towns():
	return townList

func _ready():
	GameState.prep_rand()
	townList=get_tree().get_nodes_in_group("towns")
	total_towns=townList.size()

func _townDied():
	dead_towns+=1
	_remove_town()
	_eval_towns("Death")

func _townAngry():
	angry_towns+=1
	_eval_towns("Hate")

func _townAbandoned():
	abandoned_towns+=1
	_remove_town()
	_eval_towns("Abandoned")

func _townNotAngry():
	angry_towns-=1
	_eval_towns("none")

func _eval_towns(reason: String):
	if(dead_towns+abandoned_towns+angry_towns>=total_towns):
		_game_over(reason)

func _remove_town():
	for town in townList:
		if(!town.functional()):
			townList.remove(townList.find(town))

func _game_over(reason: String):
	MapChanger.goto_scene("res://Screens/END/GameOver"+reason+".tscn")


func _input(event):
	if Input.is_action_pressed("Pause"):
		MapChanger.goto_scene("res://Screens/Menus/MainMenu/MainMenu.tscn")
	
