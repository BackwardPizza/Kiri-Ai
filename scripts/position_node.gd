class_name PositionNode extends Node2D
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

var occupied : Fighter = null

var selected : bool = false # false
var prev_selected : bool = false


func _process(_delta: float) -> void:
	if selected and not prev_selected:
		anim.play("selected")
		
	elif not selected and not prev_selected:
		anim.play("default")
		
	prev_selected = selected
