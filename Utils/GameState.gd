extends Node

var score: int =0
var spawn_rate:int = 0
var max_enemies:int = 0
var enemy_spawn_rate:int = 0
var randomizer

func _on_ready():
	randomizer=RandomNumberGenerator.new()
	randomizer.randomize()
	
func add_score(population):
	score+=population
