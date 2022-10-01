extends Node2D

class_name settlement_base
var money_per_tick: int = 0
var happiness_level: int = 0
var required_food: int = 0
var stored_food: int = 0
var tolerance: int = 0
var is_threatened: bool = false

# Food grows when the crops are watered. If stored_food >= required_food happiness increases 
func _init():
	money_per_tick = 5
	happiness_level = 10
	required_food = 20
func _process(delta):
	if stored_food >= required_food:
		happiness_level = happiness_level + 1
	else: 
		happiness_level = happiness_level - 1
	if is_threatened == true:
		happiness_level = happiness_level - 1
	if tolerance >= happiness_level:
		return money_per_tick
func _threaten_city():
	is_threatened = true
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
