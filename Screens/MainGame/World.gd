extends Node2D


var mobile : bool = true
func _ready():
	if not ["Android", "BlackBerry 10", "iOS", "UWP"].has(OS.get_name()):
		mobile=false
	if(mobile):
		$pauseButton.show()

func _on_pauseButton_pressed():
	$Mountain.spawn()

