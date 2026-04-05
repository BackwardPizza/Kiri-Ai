class_name Attack_3 extends Card

var reach := Vector2(0, 1)
	
func init() -> void:
	image.frame = 4
	var hand = get_parent().find_child("Hand")
	hand.add_card(self)
