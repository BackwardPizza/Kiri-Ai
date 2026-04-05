class_name Trainee extends Fighter
	
func init() -> void:
	stance_list = ["heaven", "earth"]
	
	var game = get_parent()
	
	var deck : Deck = preload("res://scenes/deck.tscn").instantiate()
	deck.deck_owner = self
	
	game.add_child.call_deferred(deck)
	
