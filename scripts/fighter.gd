class_name Fighter extends Actor
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

@export var node_index : int = 0
@export var enemy := false

var battlefield : Battlefield = null
var play_cards : PlayCards = null
var player : Fighter = null

var stance_list : Array[String] = []
var stance_index := 0

@export var health := 2
var health_display = null

var cards : Array[String] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	init()
	change_stance()
	
	battlefield = find_battlefield()
	if battlefield:
		move_to_location(battlefield.get_child(node_index))
	
	if enemy:
		play_cards = get_parent().find_child("PlayCards")
		player = get_parent().find_child("Player")
		health_display = get_parent().find_child("EnemyHealth")
		health_display.enemy = enemy
		anim.flip_h = true
		anim.offset += Vector2(-18.0, 0)
		battlefield.enemy = self
	else:
		health_display = get_parent().find_child("PlayerHealth")
		battlefield.player = self
		
	health_display.update_health(health)
	

		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func init() -> void:
	pass

func _process(_delta: float) -> void:
	move()
	var opponent = get_parent().find_child("Enemy")
	if not opponent == self:
		if node_index == opponent.node_index:
			global_position.x = location_node.global_position.x - 10.0
			opponent.global_position.x = location_node.global_position.x + 10.0

func find_battlefield() -> Node2D:
	return get_parent().find_child("Battlefield")
	
func set_location_node(node: Node2D) -> void:
	location_node = node
	node_index = location_node.get_index()
	
	
func change_stance() -> void:
	stance_index += 1
	if stance_index >= stance_list.size():
		stance_index = 0
	anim.play(stance_list[stance_index] + "_idle")
	
func attack() -> void:
	anim.play(stance_list[stance_index] + "_attack")

	
func take_damage(damage : int) -> void:
	health -= damage
	if health < 0: health = 0
	health_display.update_health(health)
	
	if health == 0: die()
	
func die() -> void:
	print("DIED")
	
func plan_move() -> void:
	pass
	
func move_to_location(new_location_node: PositionNode) -> void:
		set_location_node(new_location_node)
		new_location_node.occupy(self)
		node_index = new_location_node.get_index()
		
func check_move_passed(index : int) -> bool:
	if enemy:
		return index > node_index
	else:
		return index < node_index
