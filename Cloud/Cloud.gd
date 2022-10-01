extends KinematicBody2D

var mouse_over = false
var active = false
var current_destination_point_index=0
var path=[]
var my_owner=null
export var  ttl = 200
export var granulation = .1
export var max_trail_length=15
var past_positions=[]
var max_past_positions=10



func _process(delta):
	if path.size() > 0:
		if self.global_position.distance_to(path[current_destination_point_index])>4:
			self.move_and_slide((-self.global_position+path[current_destination_point_index]).normalized()*50)

	if current_destination_point_index < path.size() &&  self.global_position.distance_to(path[current_destination_point_index])<4 :
		if($SnakeTrail.get_point_count()>0):
			$SnakeTrail.remove_point(0)
		current_destination_point_index +=1
		ttl-=1
	if current_destination_point_index == path.size():
		path.clear()
		$SnakeTrail.clear_points()
		current_destination_point_index =0
	if ttl<=0:
		my_owner.im_dead()
		self.queue_free()
	$SnakeTrail.global_position=Vector2(0,0)
	#$Line2D.global_position=Vector2(0,0)

func _input(event):
	var position=get_global_mouse_position()
	if event is InputEventMouseMotion && active==true:
		
		if path.size()==0:
			path.append(position)
		if position.distance_to(path[path.size()-1])>granulation:
			path.append(position)
			_progress_line(position)
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT  and active==true and event.pressed==false:
			active=false
			mouse_over=false
		if event.button_index == BUTTON_LEFT  and event.pressed and mouse_over==true :
			$SnakeTrail.clear_points()
			path.clear()
			current_destination_point_index=0
			active =true

func set_owner(obj):
	my_owner=obj

func _on_Area2D_area_entered(area):
	if(area.is_in_group("enemies")):
		area.get_parent().deal_damage()
		$AnimatedSprite.play("Attack")
		$storm_avoid.enabled=false
	if (area.is_in_group("Town")):
		area.get_parent().rain(5)
		ttl-=5

func _on_Area2D_area_exited(area):
	$AnimatedSprite.play("Idle")
	$storm_avoid.enabled=true

func _on_Area2D_mouse_entered():
	mouse_over=true

func _on_Area2D_mouse_exited():
	mouse_over=false

func _progress_line(position):
	$SnakeTrail.add_point(position)
	#$Line2D.add_point(position)

func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "Attack":
		for i in $Area2D.get_overlapping_areas():
			if i!=null and i.is_in_group("enemies"):
				i.get_parent().deal_damage()
				ttl-=4
	elif $AnimatedSprite.animation == "Idle":
		for i in $Area2D.get_overlapping_areas():
			if i!=null and i.is_in_group("Town"):
				ttl-=5
				i.get_parent().rain(5)
		ttl -=1 
