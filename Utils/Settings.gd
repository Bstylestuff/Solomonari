extends Node

var max_score=0
var masterVolume:float=25
var townVolume:float=25
var cloudVolume:float=25
var invaderVolume:float=25
var bgmVolume:float=25

func saveSettings():
	pass
func loadSettings():
	pass
	
func update_volumes(masterV:float, townV:float, cloudV:float, invaderV:float, bgmV:float):
	masterVolume=masterV
	townVolume=townV
	cloudVolume=cloudV
	invaderVolume=invaderV
	bgmVolume=bgmV
	
	setVolume(masterVolume, "Master")
	setVolume(townVolume, "SFX_town")
	setVolume(cloudVolume,"SFX_cloud")
	setVolume(invaderVolume, "SFX_enemies")
	setVolume(bgmVolume,"BGM")

func setVolume(volume:float, bus:String):
	var final_volume="test"
	if(volume==0):
		AudioServer.set_bus_mute(AudioServer.get_bus_index(bus), true)
	if(volume==25):
		final_volume=0
	else:
		if(volume<25):
			final_volume= range_lerp(volume,0,25,-80,0)
		if(volume>25):
			final_volume= range_lerp(volume,25,100,0,12)
	print(final_volume)
	if(str(final_volume).is_valid_float()):
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index(bus),final_volume)
		
