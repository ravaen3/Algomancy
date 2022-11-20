extends Area2D
var card = preload("res://Scenes/Main/Game/card.tscn")
var deck = []
var hidden_zone = true
func _ready():
	pass
	
@rpc
func set_deck(deck_list):
	if multiplayer.is_server():
		await get_tree().create_timer(0.1).timeout
		rpc("set_deck", deck_list)
	for card_name in deck_list:
		var card_instance = card.instantiate()
		card_instance.name = card_name
		deck.append(card_instance)
	format()
	
func format(bottom = false):
	var bot_card = null
	for child in get_children():
		if child.is_in_group("Card"):
			child.position = Vector2(0,0)
			if bot_card:
				if bottom:
					deck.push_front(child)
					remove_child(child)
				else:
					deck.append(bot_card)
					remove_child(bot_card)
			else:
				bot_card = child
	if !bot_card:
		bot_card = deck.pop_back()
		add_child(bot_card)
