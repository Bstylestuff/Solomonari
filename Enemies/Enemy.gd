extends KinematicBody2D

var target= null
var hp = 5
var my_owner = null
var speed = 120
var dying=false
var hitting_town=false
var target_town=null

var sounds = {
	"siege": "res://Enemies/turk/Art/Audio/enemy_hits_town.wav",
	"thunderStruck":"res://Enemies/turk/Art/Audio/enemy_hit_by_cloud.wav"}

func _ready():
	$NavigationAgent2D.set_target_location(global_position)
	sounds["siege"]=load(sounds["siege"])
	sounds["thunderStruck"]=load(sounds["thunderStruck"])

func _physics_process(_delta):
	if target !=null:
		
		$NavigationAgent2D.set_target_location(target)
		
		var next_location = $NavigationAgent2D.get_next_location()
		
		var velocity = self.global_position.direction_to(next_location)*speed
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
		$AudioStreamPlayer2D.stream=sounds["thunderStruck"]
		$AudioStreamPlayer2D.play()
		dying=true
	
func die():
	my_owner.i_died()
	self.queue_free()

func _on_AudioStreamPlayer2D_finished():
	if(dying):
		die()
	elif(hitting_town):
		if(target_town !=null):
			target_town.siege()
			$AudioStreamPlayer2D.play()
		else:
			hitting_town=false
			die()


func _on_Area2D_area_entered(area):
	if(area.is_in_group("Town")):
		area.get_parent().siege()
		target_town=area.get_parent()
		if !target_town.functional():
			die()
		hitting_town=true
		$AudioStreamPlayer2D.stream=sounds["siege"]
		$AudioStreamPlayer2D.play()
		
