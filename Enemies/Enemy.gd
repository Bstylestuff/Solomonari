extends KinematicBody2D

var target= null
var hp = 5
var my_owner = null
var speed = 120


func _ready():
	$NavigationAgent2D.set_target_location(global_position)

func _physics_process(_delta):
	if target !=null:
		
		$NavigationAgent2D.set_target_location(target)
		
		var next_location = $NavigationAgent2D.get_next_location()
		
		var velocity = self.global_position.direction_to(next_location)*speed*_delta
		velocity = move_and_slide(velocity)

func set_image(img):
	$Sprite.texture=img
	return

func set_owner(obj):
	my_owner=obj
	return

func set_speed(new_speed):
	speed=new_speed
	return

func set_hp(new_hp):
	hp=new_hp
	return

func set_target(object):
	if object!=null:
		target=object
	return

func deal_damage():
	hp-=1
	if hp ==0:
		my_owner.i_died()
		self.queue_free()
	return
