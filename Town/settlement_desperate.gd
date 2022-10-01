extends settlement_base

class_name desperate_settlement
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func _init():
	tolerance = 3
	money_per_tick = 2
	happiness_level = 5
	is_threatened = false
	required_food = 30
	stored_food = 0
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

