extends KinematicBody2D


var mouse_over = false
var active = false
var path_follow=true
var point_to_loffow=0
var path_to_folow=[]
var t = 0
export var  ttl = 500

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if path_to_folow.size() > 0:
		if path_follow ==true:
			t += delta*0.2
			if self.global_position.distance_to(path_to_folow[point_to_loffow])>3:
				self.global_position=self.global_position.linear_interpolate(path_to_folow[point_to_loffow],t)
	
	if point_to_loffow < path_to_folow.size() &&  self.global_position.distance_to(path_to_folow[point_to_loffow])<3 :
		point_to_loffow +=1
		t=0 
	if point_to_loffow == path_to_folow.size():
		path_to_folow.clear()
		t=0
		point_to_loffow =0


func _input(event):
	
	if event is InputEventMouseMotion && active==true:
		
		path_to_folow.append(get_global_mouse_position())
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
	pass # Replace with function body.


func _on_Area2D_mouse_exited():
	mouse_over=false
	pass # Replace with function body.
