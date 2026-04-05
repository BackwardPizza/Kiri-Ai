class_name Card extends Actor
@onready var button: Button = $Button
@onready var base: Sprite2D = $Button/Base
@onready var image: Sprite2D = $Button/Image
@onready var rotate_button: Button = $"Rotate Button"

var flipped := -1
var can_rotate := false

func _ready() -> void:
	init()
	load_textures()

func init() -> void:
	pass
	
func load_textures() -> void:
	var texture = load("res://assets/cards.png")
	base.texture = texture
	image.texture = texture
	
func _process(_delta: float) -> void:
	on_hover()
	move_to()

func on_hover() -> void:
	if context == self or not context: return
	
	if button.is_hovered() or rotate_button.is_hovered():
		rotate_button.visible = can_rotate
		scale = location_node.scale * 1.2
		rotation = 0.0
		z_index = 100
		
	else:
		rotate_button.visible = false
		scale = location_node.scale
		rotation = location_node.rotation
		z_index = location_node.z_index


func _on_button_pressed() -> void:
	context.action(self)

func _on_rotate_button_pressed() -> void:
	flipped *= -1
	image.flip_v = flipped > 0
