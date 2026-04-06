class_name Deck extends Node2D

var deck_owner : Fighter = null
var hand : Hand = null
var battlefield : Battlefield = null

func _ready() -> void:
	if not deck_owner:
		print("Deck initiated without owner")
		return
	
	battlefield = deck_owner.battlefield
	
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
	var cards = deck_owner.cards
	var enemy = deck_owner.enemy
	
	for card in cards:
		#create card with correct script
		var new_card: Card = load("res://scenes/card.tscn").instantiate()
		var script = load("res://scripts/"+ card +".gd")
		new_card.set_script(script)
		
		#hide card and flip effected area if card owner is enemy
		new_card.visible = not deck_owner.enemy
		new_card.name = card
		
		add_child(new_card)
		
		if enemy:
			new_card.effected_area *= -1
