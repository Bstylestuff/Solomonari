extends settlement_base

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

class_name picky_settlement
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func _init():
	tolerance = 7
	money_per_tick = 10
	happiness_level = 3
	is_sieged = false
	required_food = 70
	stored_food = 0
