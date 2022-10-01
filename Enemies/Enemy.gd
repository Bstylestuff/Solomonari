extends KinematicBody2D

var target= null

var speed = 100

func _ready():
	$NavigationAgent2D.set_target_location(global_position)

func _physics_process(_delta):
	$NavigationAgent2D.set_target_location(get_global_mouse_position())
	
	var next_location = $NavigationAgent2D.get_next_location()
	
	var velocity = self.global_position.direction_to(next_location)*speed*_delta 
	velocity = move_and_slide(velocity)



func set_target(object):
	if object!=null:
		target=object
	return
