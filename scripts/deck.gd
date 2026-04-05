class_name Deck extends Node2D

var deck_owner : Fighter = null
var hand : Hand = null

func _ready() -> void:
	if not deck_owner:
		print("Deck initiated without owner")
		return
		
	create_cards()
	
	if not deck_owner.enemy:
		hand = get_parent().find_child("Hand")
		
	if hand:
		for child in get_children():
			hand.add_card(child)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func add_card(_card : Card) -> void:
	pass
	
func remove_card(_card : Card) -> void:
	pass
	
func create_cards() -> void:
	var cards = ["move", "attack_1", "attack_2"]
	
	for card in cards:
		var new_card: Card = load("res://scenes/card.tscn").instantiate()
		var script = load("res://scripts/"+ card +".gd")
		new_card.set_script(script)
		new_card.visible = not deck_owner.enemy
		add_child(new_card)
