class_name Heart extends Node2D

var index
var length_between := 10.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if index:
		position.x += index * length_between
