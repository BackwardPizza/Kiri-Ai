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
	
	if enemy:
		play_cards = get_parent().find_child("PlayCards")
		player = get_parent().find_child("Player")
		health_display = get_parent().find_child("EnemyHealth")
		health_display.enemy = enemy
		anim.flip_h = true
		anim.offset += Vector2(-18.0, 0)
	else:
		health_display = get_parent().find_child("PlayerHealth")
		
	health_display.update_health(health)
	
	battlefield = find_line_array()
	if battlefield:
		var result = battlefield.get_nodes_at_location(self, Vector2(0, 1))
		set_location_node(result[0])
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func init() -> void:
	pass

func _process(_delta: float) -> void:
	move_to()
	if anim.animation == stance_list[stance_index] + "_attack" and anim.animation_finished:
		anim.play(stance_list[stance_index] + "_idle")
		

func find_line_array() -> Node2D:
	return get_parent().find_child("Battlefield")
	
func set_location_node(node: Node2D) -> void:
	if location_node and location_node is PositionNode:
		location_node.occupied = null
	
	location_node = node
	location_node.occupied = self
	node_index = location_node.get_index()
	
	
func change_stance() -> void:
	anim.play(stance_list[stance_index] + "_idle")
	stance_index += 1
	if stance_index >= stance_list.size():
		stance_index = 0
	
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
