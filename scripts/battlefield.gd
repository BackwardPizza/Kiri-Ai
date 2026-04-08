class_name Battlefield extends Node2D

@export var length : int = 7
@export var node_scale : float = 1.4
var distance_between := 40.0

var player : Fighter = null
var enemy : Fighter = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	center_battlefield()
	spawn_nodes()


# potensially remove fighter variable, and replace it with the figther index
func get_nodes_at_location(fighter: Fighter, distance: Vector2) -> Array[PositionNode]:
	var result : Array[PositionNode] = []
	var direction : int = sign(distance.y)
	
	var fighter_index := get_fighter_index(fighter)

	for i in range(abs(distance.y)):
		var index : int = fighter_index + int(distance.x) + int(i * direction)
		
		if not out_of_bound(index):
			var index_is_passed_opponent : bool = false
			if fighter.enemy:
				index_is_passed_opponent = player.check_move_passed(index)
			else:
				index_is_passed_opponent = enemy.check_move_passed(index)
				
			if not index_is_passed_opponent:
				var pos_node = get_child(index)
				result.append(pos_node)
	
	return result
	
func out_of_bound(index: int) -> bool:
	return index < 0 or index > get_child_count() - 1
	
func get_fighter_index(fighter: Fighter) -> int:
	for child: PositionNode in get_children():
		if fighter in child.occupied:
			return child.get_index()
	return 0
	
func center_battlefield() -> void:
	global_position.x = get_viewport_rect().position.x
	global_position.x -= float(length - 1) * distance_between / 2
	
func spawn_nodes() -> void:
	for i in range(length):
		var new_position_node: PositionNode = load("res://scenes/position_node.tscn").instantiate()
		new_position_node.scale *= node_scale
		add_child(new_position_node)
		new_position_node.new_fighter.connect(_on_new_fighter)
		new_position_node.position.x = i * distance_between
	
func _on_new_fighter(fighter : Fighter) -> void:
	for child : PositionNode in get_children():
		if child.remove_fighter(fighter): break
