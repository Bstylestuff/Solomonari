extends Node


var masterVolume=25
var cloudVolume=25
var townVolume=25
var invaderVolume=25
var musicVolume = 25

var default=25


func _ready():
	if(Settings.masterVolume != null):
		masterVolume=Settings.masterVolume
	else:
		_on_MasterReset_pressed()
	if(Settings.cloudVolume != null):
		cloudVolume=Settings.cloudVolume
	else:
		_on_CloudReset_pressed()
	if(Settings.invaderVolume != null):
		invaderVolume=Settings.invaderVolume
	else:
		_on_InvaderReset_pressed()
	if(Settings.townVolume != null):
		townVolume=Settings.townVolume
	else:
		_on_TownReset_pressed()
	if(Settings.bgmVolume != null):
		townVolume=Settings.bgmVolume
	else:
		_on_MusicReset_pressed()

func _on_MasterReset_pressed():
	$HBoxContainer2/VBoxContainer/HBoxContainer6/VBoxContainer2/MasterSlider.value=default

func _on_CloudReset_pressed():
	$HBoxContainer2/VBoxContainer/HBoxContainer6/VBoxContainer2/CloudSlider.value=default

func _on_TownReset_pressed():
	$HBoxContainer2/VBoxContainer/HBoxContainer6/VBoxContainer2/TownSlider.value=default

func _on_InvaderReset_pressed():
	$HBoxContainer2/VBoxContainer/HBoxContainer6/VBoxContainer2/InvaderSlider.value=default

func _on_MasterSlider_value_changed(value):
	masterVolume=value
	$HBoxContainer2/VBoxContainer/HBoxContainer6/VBoxContainer3/MasterLabel.text=str(value)

func _on_CloudSlider_value_changed(value):
	cloudVolume=value
	$HBoxContainer2/VBoxContainer/HBoxContainer6/VBoxContainer3/CloudLabel.text=str(value)

func _on_TownSlider_value_changed(value):
	townVolume=value
	$HBoxContainer2/VBoxContainer/HBoxContainer6/VBoxContainer3/TownLabel.text=str(value)

func _on_InvaderSlider_value_changed(value):
	invaderVolume=value
	$HBoxContainer2/VBoxContainer/HBoxContainer6/VBoxContainer3/InvaderLabel.text=str(value)

func _on_apply_but_pressed():
	Settings.update_volumes(masterVolume,townVolume, cloudVolume, invaderVolume, musicVolume)
	MapChanger.goto_scene("res://Screens/Menus/MainMenu/MainMenu.tscn")

func _on_back_but_pressed():
	MapChanger.goto_scene("res://Screens/Menus/MainMenu/MainMenu.tscn")


func _on_MusicSlider_value_changed(value):
	musicVolume=value
	$HBoxContainer2/VBoxContainer/HBoxContainer6/VBoxContainer3/MusicLabel.text=str(value)

func _on_MusicReset_pressed():
	$HBoxContainer2/VBoxContainer/HBoxContainer6/VBoxContainer2/MusicSlider.value=default
