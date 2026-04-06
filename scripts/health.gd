class_name Health extends Node2D

var current_health : Array[Node2D] = []
var enemy := false

func update_health(new_value: int) -> void:
	while current_health.size() != new_value:
		if current_health.size() > new_value:
			decrease()
		else:
			increase()

func increase() -> bool:
	var heart = preload("res://scenes/heart.tscn").instantiate()
	heart.index = current_health.size()
	if enemy: heart.length_between *= -1.0
	add_child(heart)
	current_health.append(heart)
	
	return true
	
func decrease() -> bool:
	if current_health.size() != 0:
		var heart = current_health[-1]
		current_health.erase(heart)
		heart.queue_free()
		
		return true
	else:
		return false
