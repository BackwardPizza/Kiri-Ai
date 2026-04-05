class_name PlayCards extends CardArea

@onready var first: CardSlot = $First
@onready var second: CardSlot = $Second

var slots : Array[Card] = [null, null]

func _process(_delta: float) -> void:
	if slots[0] == null:
		if slots[1] != null:
			slots[0] = slots[1]
			slots[1] = null
			slots[0].set_location_node(first)
	
func add_card(card : Card) -> void:
	card.change_context(self)
	
	if slots[0] == null:
		print("Slot 0: ", slots[0])
		slots[0] = card
		card.set_location_node(first)
		
	elif slots[1] == null:
		print("Slot 1: ", slots[1])
		slots[1] = card
		card.set_location_node(second)
	
func remove_card(card : Card) -> void:
	if card == slots[0]:
		slots[0] = null
	if card == slots[1]:
		slots[1] = null
