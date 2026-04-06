class_name PlayTurnButton extends Node2D
@onready var button: Button = $Button

var default_scale : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	default_scale = scale


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if button.is_hovered():
		scale = default_scale * 1.2
	else:
		scale = default_scale


func _on_button_pressed() -> void:
	get_parent().play_turn()
