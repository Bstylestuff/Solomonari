extends KinematicBody2D


var mouse_over = false
var active = false
var path_follow=true
var point_to_loffow=0
var path_to_folow=[]
export var  ttl = 500

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print("NOW")
	for i in range(1, path_to_folow.size()):
		print(path_to_folow[i-1].distance_to(path_to_folow[i]))
	if path_to_folow.size() > 0:
		if path_follow ==true:
			if self.global_position.distance_to(path_to_folow[point_to_loffow])>4:
				self.move_and_slide((-self.global_position+path_to_folow[point_to_loffow]).normalized()*100)
				#self.global_position=self.global_position.linear_interpolate(path_to_folow[point_to_loffow],delta*5)
	
	if point_to_loffow < path_to_folow.size() &&  self.global_position.distance_to(path_to_folow[point_to_loffow])<4 :
		point_to_loffow +=1
	if point_to_loffow == path_to_folow.size():
		path_to_folow.clear()
		point_to_loffow =0
	$Line2D.global_position=Vector2(0,0)


func _input(event):
	
	if event is InputEventMouseMotion && active==true:
		if path_to_folow.size()==0:
			path_to_folow.append(get_global_mouse_position())
		if get_global_mouse_position().distance_to(path_to_folow[path_to_folow.size()-1])>18:
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


func _on_Area2D_mouse_entered():
	mouse_over=true

func _on_Area2D_mouse_exited():
	mouse_over=false
