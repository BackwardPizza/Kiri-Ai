class_name PositionNode extends Node2D
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

var occupied : Array[Fighter] = []
signal  new_fighter(fighter: Fighter)

var selected : bool = false
var prev_selected : bool = false

func occupy(fighter: Fighter) -> void:
	new_fighter.emit(fighter)
	occupied.append(fighter)
	
func remove_fighter(fighter: Fighter) -> bool:
	for elem in occupied:
		if elem == fighter:
			occupied.erase(fighter)
			return true
			
	return false

func _process(_delta: float) -> void:
	if selected and not prev_selected:
		anim.play("selected")
		
	elif not selected and not prev_selected:
		anim.play("default")
		
	prev_selected = selected
	
	if occupied.size() > 1: 
		anim.play("occupied_by_both_players")
