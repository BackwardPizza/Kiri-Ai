class_name PlayCards extends CardArea

@onready var first: CardSlot = $First
@onready var second: CardSlot = $Second
@onready var enemy: Trainee = $"../Enemy"

var hand : Hand = null
var slots : Array[Card] = [null, null]
var enemy_cards : Array[Card] = [null, null]

func _process(_delta: float) -> void:
	shuffle_cards()
			
func shuffle_cards() -> void:
	if slots[0] == null:
		if slots[1] != null:
			slots[0] = slots[1]
			slots[1] = null
			slots[0].set_location_node(first) #might need work
	
func add_card(card : Card) -> bool:
	if slots[0] == null:
		slots[0] = card
		card.change_context(self)
		card.set_location_node(first)
		return true
		
	elif slots[1] == null:
		slots[1] = card
		card.change_context(self)
		card.set_location_node(second)
		return true
	
	else:
		return false
	
func remove_card(card : Card) -> bool:
	if card == slots[0]:
		slots[0] = null
		return true
	if card == slots[1]:
		slots[1] = null
		return true
	
	return false
		
func action(card: Card) -> void:
	hand = get_parent().find_child("Hand")
	if not hand: return
	
	if hand.add_card(card):
		remove_card(card)
		
func play_turn() -> void:
	print("Play turn")
	
	enemy.plan_move()
	
	if slots[0] and slots[1]:
		if enemy_cards[0] and enemy_cards[1]:
			
			print("Executing Players First Card: ", slots[0].name)
			slots[0].effect()
			action(slots[0])
			
			print("Executing Enemys First Card: ", enemy_cards[0].name)
			enemy_cards[0].effect()
			
			print("Executing Players Second Card: ", slots[1].name)
			slots[1].effect()
			action(slots[1])
			
			print("Executing Enemys Second Card: ", enemy_cards[1].name)
			enemy_cards[0].effect()
