class_name Card extends Actor
@onready var button: Button = $Button
@onready var base: Sprite2D = $Button/Base
@onready var image: Sprite2D = $Button/Image
@onready var rotate_button: Button = $"Rotate Button"

var priority : int = 1

var flipped := false
var can_rotate := false
var effected_area := Vector2.ZERO
var effected_nodes : Array[PositionNode] = []

func _ready() -> void:
	init()
	load_textures()

func init() -> void:
	pass
	
func _process(_delta: float) -> void:
	move()
	refresh_effected_nodes()
	on_hover()
	
	
func effect() -> void:
	attack()
	refresh_effected_nodes()
	
	for node in effected_nodes:
		for fighter in node.occupied:
			if fighter != get_parent().deck_owner:
				fighter.take_damage(1)

func attack() -> void:
	var fighter : Fighter = get_parent().deck_owner
	fighter.attack()


func get_effected_battlefield_nodes() -> Array[PositionNode]:
	var battlefield : Battlefield = get_parent().battlefield
	var fighter : Fighter = get_parent().deck_owner
	
	if battlefield:
		return battlefield.get_nodes_at_location(fighter, effected_area)
	return []
	
func refresh_effected_nodes() -> void:
	effected_nodes = get_effected_battlefield_nodes()

func load_textures() -> void:
	var texture = load("res://assets/cards.png")
	base.texture = texture
	image.texture = texture
	
func was_flipped() -> void:
	flipped = not flipped
	image.flip_v = flipped

func on_hover() -> void:
	if context == self or not context: return
	if is_moving: return
	
	if button.is_hovered() or rotate_button.is_hovered():
		rotate_button.visible = can_rotate
		if context is Hand:
			global_position.y = location_node.global_position.y - 20.0
		scale = location_node.scale * 1.2
		rotation = 0.0
		z_index = 1000
		
		for node in effected_nodes:
			node.selected = true
		
	else:
		rotate_button.visible = false
		scale = location_node.scale
		rotation = location_node.rotation
		z_index = location_node.z_index
		
		for node in effected_nodes:
			if node.prev_selected:
				node.selected = false

func _on_button_pressed() -> void:
	is_moving = true
	context.action(self)

func _on_rotate_button_pressed() -> void:
	was_flipped()
