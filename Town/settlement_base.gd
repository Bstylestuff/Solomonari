extends Node2D

class_name settlement_base

var money_per_tick: int = 0
var pay_rate: int = 0
var happiness_level: int = 0
var required_food: int = 0
var stored_food: int = 0
var tolerance: int = 0
var is_sieged: bool = false
var can_pay:bool = false
var curr_happiness_total:int = 30
var hp: int = 30
var crops:int = 50
var population:int = 10
var min_crops:int = 10
var turn_duration:int = 5
var curr_turn:float=0
var angry:bool=false
var dead:bool=false
var abandoned:bool=false
var sent_anger:bool=false

var sounds = {
	"pay": "res://Town/Art/Audio/pickup_money.wav",
	"anger":"res://Town/Art/Audio/town_angry.wav",
	"need":"res://Town/Art/Audio/town_needs_water.wav"}

func _ready():
	sounds["pay"]=load(sounds["pay"])
	sounds["anger"]=load(sounds["anger"])
	sounds["need"]=load(sounds["need"])
	$FeelBubble.hide()
	$NeedBubble.hide()
	$Pay.hide()
	
func _init():
	money_per_tick = 5
	happiness_level = 10
	required_food = 2

func functional():
	return not (dead or abandoned)

func _physics_process(delta):
	curr_turn+=delta
	if(curr_turn>turn_duration):
		_pass_turn()
		curr_turn-=turn_duration

func _pass_turn():
	if(dead or abandoned):
		return
	_update_status()
	_eval_happiness()
	if(can_pay):
		if(stored_food>required_food*population*2):
			_decrease_storage(required_food*population)
			pay()

func _update_status():
	_eval_food()
	if is_sieged == true:
		happiness_level -= 1
		hp-=1
	if hp==0:
		_die()

func _eval_food():
	_consume_food()
	if stored_food >= required_food*population:
		_add_happiness(stored_food-required_food*population)
	else: 
		happiness_level -= 1

func _consume_food():
	_decrease_storage(required_food*population)
	if(stored_food<0):
		_pop_death()
	stored_food+=crops
	_decrease_crops(population)
	if(crops<min_crops):
		_need()
	if(crops>required_food*population):
		_birth()

func _eval_happiness():
	if(happiness_level<tolerance):
		can_pay=false
		_anger()
	else:
		can_pay=true

func siege():
	is_sieged = true

func pay():
	$AnimationPlayer.play("TownPay")
	$AudioStreamPlayer2D.stream=sounds["pay"]
	$AudioStreamPlayer2D.play()

func _need():
	$AnimationPlayer.play("WantRain")
	$AudioStreamPlayer2D.stream=sounds["need"]
	$AudioStreamPlayer2D.play()

func _anger():
	angry=true
	if(not sent_anger):
		get_parent().get_parent().emit_signal("angry")
		sent_anger=true
	$AnimationPlayer.play("Angry")
	$AudioStreamPlayer2D.stream=sounds["anger"]
	$AudioStreamPlayer2D.play()

func _pay_up():
	GameState.add_score(population)

func _die():
	get_parent().get_parent().emit_signal("death")
	dead=true


func rain(amount):
	crops+=amount
	
func _birth():
	if(GameState.randomizer.randi_range(0,100)>40):
		_decrease_crops(30)
		population+=1

func _pop_death():
	population-=1
	happiness_level-=3
	if(population==0):
		_abandon()

func _abandon():
	get_parent().get_parent().emit_signal("abandoned")
	abandoned=true

func _decrease_storage(amount):
	stored_food-=amount
	if(stored_food<0):
		stored_food=0
		
func _decrease_crops(amount):
	crops-=amount
	if(crops<0):
		crops=0

func _add_happiness(amount):
	happiness_level+=amount
	if(angry):
		if(happiness_level>0):
			get_parent().get_parent().emit_signal("notAngry")
			sent_anger=false
	if(happiness_level>15):
		happiness_level=15
