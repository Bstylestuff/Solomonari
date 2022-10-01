extends settlement_base

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

class_name standard_settlement
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func _init():
	tolerance = 5
	money_per_tick = 5
	happiness_level = 3
	is_threatened = false
	required_food = 50
	stored_food = 0
