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
var curr_happiness_total:int = 300
var hp: int = 300
var crops:int = 500
var population:int = 10
var min_crops:int = 100
var turn_duration:int = 5
var curr_turn:float=0

func _init():
	money_per_tick = 5
	happiness_level = 10
	required_food = 2

func _physics_process(delta):
	curr_turn+=delta
	if(curr_turn>turn_duration):
		_pass_turn()
		curr_turn-=turn_duration
		

func _pass_turn():
	_update_status()
	_eval_happiness()
	if(can_pay):
		if(stored_food>required_food*population*2):
			stored_food-=required_food*population
			pay()

func _update_status():
	_eval_food()
	if is_sieged == true:
		happiness_level = happiness_level - 1
		hp-=1
	if hp==0:
		_die()

func _eval_food():
	_consume_food()
	if stored_food >= required_food:
		happiness_level += 1
	else: 
		happiness_level -= 1

func _consume_food():
	
	stored_food-=required_food*population
	if(stored_food<0):
		_pop_death()
	stored_food+=crops
	crops-=population
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

func _need():
	$AnimationPlayer.play("WantRain")

func _anger():
	$AnimationPlayer.play("Angry")

func _pay_up():
	GameState.add_score(population)

func _die():
	pass

func rain(amount):
	crops+=amount
	
func _birth():
	if(GameState.randomizer.randi_range(0,100)>40):
		crops-=30
		population+=1

func _pop_death():
	population-=1
	happiness_level-=3
	if(population==0):
		_die()
