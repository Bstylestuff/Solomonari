extends Node2D


var mobile : bool = true
func _ready():
	if not ["Android", "BlackBerry 10", "iOS", "UWP"].has(OS.get_name()):
		mobile=false
	if(mobile):
		$pauseButton.show()
	GameState.prep_rand()
