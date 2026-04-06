class_name Trainee extends Fighter
	
func init() -> void:
	stance_list = ["heaven", "earth"]
	cards = [ "attack_1", "attack_2", "attack_3", "move", "stance_change"]
	
	var game = get_parent()
	var deck : Deck = preload("res://scenes/deck.tscn").instantiate()
	deck.deck_owner = self
	
	game.add_child.call_deferred(deck)


func plan_move() -> void:
	var deck : Deck = null
	for child in get_parent().get_children():
		if child is Deck:
			if child.deck_owner == self:
				deck = child
				
	if not deck:
		return
	
	
	var distance_between_fighters = abs(node_index - player.node_index)
	print("Distance between fighters: ", distance_between_fighters)
	
	var first_card : Card = null
	
	for card : Card in deck.get_children():
		print(card.effected_area)
		if abs(card.effected_area.length()) >= distance_between_fighters:
			print("Found card with range: ", card.effected_area)
			first_card = card
			break
	
	if not first_card:
		print("Could not reach with any card. First card is set to Move 1")
		first_card = deck.get_child(3)
		
	play_cards.enemy_cards[0] = first_card
	
	var second_card : Card = null
	
	for card : Card in deck.get_children():
		if abs(card.effected_area.length()) >= distance_between_fighters:
			print("Found card with range: ", card.effected_area)
			second_card = card
			break
	
	if not second_card:
		print("Could not reach with any card. Second card is set to Move 1")
		second_card = deck.get_child(3)
		
	play_cards.enemy_cards[1] = second_card
	
	
