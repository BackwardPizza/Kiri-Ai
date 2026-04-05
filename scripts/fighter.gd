class_name Fighter extends Actor
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

@export var node_index : int = 0
@export var enemy := false

var array_node : Node2D = null
var battlefield : Battlefield = null

var stance_list : Array[String] = []
var stance := "heaven"

@export var health := 2
var health_display = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	init()
	
	if enemy:
		anim.flip_h = true
		anim.offset += Vector2(-18.0, 0)
	
	battlefield = find_line_array()
	if battlefield:
		var result = battlefield.get_nodes_at_location(self, Vector2(0, 1))
		print(result)
		location_node = result[0]
		
	health_display = get_parent().find_child("Health")
	health_display.update_health(health)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func init() -> void:
	pass

func _process(_delta: float) -> void:
	move_to()
	if enemy: return
	if not array_node: return
		
	if Input.is_action_just_pressed("ui_accept"):
		change_stance("earth")
		take_damage(1)

func find_line_array() -> Node2D:
	return get_parent().find_child("Battlefield")
	
		
func attack() -> void:
	anim.play(stance + "_attack")
	
func change_stance(new_stance: String) -> void:
	var index = 0
	while index < stance_list.size():
		if new_stance == stance_list[index]:
			stance = stance_list[index]
			anim.play(stance + "_idle")
		index += 1
	
	
func take_damage(damage : int) -> void:
	health -= damage
	if health < 0: health = 0
	health_display.update_health(health)
	
	if health == 0: die()
	
func die() -> void:
	print("DIED")
