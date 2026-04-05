class_name StartPosition extends Node2D

var card_amount : int = 0
var distance_between_cards := 20.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	card_amount = get_child_count()
	move_cards()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func move_cards() -> void:
	position.x = 0 - ( card_amount * distance_between_cards / 2 )
