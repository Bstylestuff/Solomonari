extends KinematicBody2D


var mouse_over = false
var active = false
var path_follow=true
var point_to_loffow=0
var path_to_folow=[]
var my_owner=null
export var  ttl = 200
export var granulation = 18

func _process(delta):
	if path_to_folow.size() > 0:
		if path_follow ==true:
			if self.global_position.distance_to(path_to_folow[point_to_loffow])>4:
				self.move_and_slide((-self.global_position+path_to_folow[point_to_loffow]).normalized()*50)


	if point_to_loffow < path_to_folow.size() &&  self.global_position.distance_to(path_to_folow[point_to_loffow])<4 :
		point_to_loffow +=1
		ttl-=1
	if point_to_loffow == path_to_folow.size():
		path_to_folow.clear()
		point_to_loffow =0
	if ttl<=0:
		my_owner.im_dead()
		self.queue_free()
	$Line2D.global_position=Vector2(0,0)

func _input(event):
	if event is InputEventMouseMotion && active==true:
		if path_to_folow.size()==0:
			path_to_folow.append(get_global_mouse_position())
		if get_global_mouse_position().distance_to(path_to_folow[path_to_folow.size()-1])>granulation:
			path_to_folow.append(get_global_mouse_position())
			$Line2D.add_point(get_global_mouse_position())
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT  and active==true and event.pressed==false:
			active=false
			mouse_over=false
		if event.button_index == BUTTON_LEFT  and event.pressed and mouse_over==true :
			path_to_folow.clear()
			point_to_loffow=0
			active =true

func set_owner(obj):
	my_owner=obj
	return

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


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "Attack":
		for i in $Area2D.get_overlapping_areas():
			if i!=null and i.is_in_group("enemies"):
				i.get_parent().deal_damage()
				ttl-=7
	elif $AnimatedSprite.animation == "Idle":
		for i in $Area2D.get_overlapping_areas():
			if i!=null and i.is_in_group("Town"):
				ttl-=5
				i.get_parent().rain(5)
		ttl -=1 
	
	pass # Replace with function body.
