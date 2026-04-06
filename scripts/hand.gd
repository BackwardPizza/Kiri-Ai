class_name Hand extends CardArea
@onready var starting_pos: Node2D = $StartingPos

var cards_in_hand : Array[Card] = []
var distance_between_cards := 40.0

var playcards : PlayCards = null

func _ready() -> void:
	center_hand()
	
func _process(_delta: float) -> void:
	center_cards()
	angle_cards()
		

func add_card(card : Card) -> bool:
	cards_in_hand.append(card)
	var card_slot = CardSlot.new()
	starting_pos.add_child(card_slot)
	
	card.change_context(self)
	card.set_location_node(card_slot)
	return true
	
func remove_card(card : Card) -> bool:
	var index := 0
	for child in starting_pos.get_children():
		if cards_in_hand[index] == card:
			starting_pos.remove_child(child)
			child.queue_free()
			cards_in_hand.erase(card)
			return true
		index += 1
	return false
	
	
func get_location_node(index: int) -> Node2D:
	return starting_pos.get_child(index)
	
	
func action(card: Card) -> void:
	playcards = get_parent().find_child("PlayCards")
	if not playcards: return
	
	if playcards.add_card(card):
		remove_card(card)
	
func center_cards() -> void:
	starting_pos.position.x = 1 - (((cards_in_hand.size() - 1) * distance_between_cards) / 2)
	
func center_hand() -> void:
	global_position.x = get_viewport_rect().position.x

func angle_cards() -> void:
	var half : float = (cards_in_hand.size() - 1) / 2.0
	for child in starting_pos.get_children():
		child.position.x = child.get_index() * distance_between_cards
		child.rotation = 0.05 * (child.get_index() - half)
