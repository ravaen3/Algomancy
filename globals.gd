extends Node2D
var cards
var deck_list
var player_id = 0
var multiplayer_peer = ENetMultiplayerPeer.new()
var is_playing = false
# Called when the node enters the scene tree for the first time.
func _ready():
	update_cards()
	var file =FileAccess.open("res://Assets/Cards/cards.json", FileAccess.READ)
	var json = JSON.new()
	json.parse(file.get_as_text())
	cards = json.get_data()

func update_cards():
	var request = HTTPRequest.new()
	add_child(request)
	request.request_completed.connect(self._on_json_importer_request_completed)
	request.request("https://calebgannon.com/wp-content/uploads/algomancy-extras/AlgomancyCards.json")

func _on_json_importer_request_completed(_result, _response_code, _headers, body):
	var file = FileAccess.open("res://Assets/Cards/cards.json", FileAccess.WRITE)
	file.store_string(body.get_string_from_utf8())



@rpc
func start_game(format, factions):
	is_playing = get_tree().root.get_node("Lobby/LobbyMenu/VBoxContainer/Playing").button_pressed
	get_tree().change_scene_to_file("res://Scenes/Main/Game/game.tscn")
	if multiplayer.is_server():
		deck_list = generate_deck(factions)
		rpc("start_game", format, factions)
		await get_tree().create_timer(0.1).timeout
		get_tree().root.get_node("Game").get_node("Deck").set_deck(deck_list)
	
func generate_deck(factions):
	var decklist = []
	for card in Global.cards:
		var include = true
		card = Global.cards.get(card)[0]
		for faction in card.get("factions"):
			if faction in factions:
				pass
			else:
				include = false
		if include:
			decklist.append(card.name)
	decklist.shuffle()
	var file = FileAccess.open("res://Assets/Cards/deck.txt", FileAccess.WRITE)
	var decklistStr = ""
	for card in decklist:
		decklistStr+="1 "+card+"\n"
	file.store_string(decklistStr)
	return decklist
	
func host_server(port):
	multiplayer_peer.create_server(port)
	multiplayer.multiplayer_peer = multiplayer_peer
	multiplayer_peer.peer_connected.connect(
		func(new_peer_id):
			print("player connected")
	)
	get_tree().change_scene_to_file("res://Scenes/Main/Lobby/lobby.tscn")

func join_server(ip, port):
	multiplayer_peer.create_client(ip, port)
	multiplayer.multiplayer_peer = multiplayer_peer
	multiplayer.connected_to_server.connect(
		func():
			get_tree().change_scene_to_file("res://Scenes/Main/Lobby/lobby.tscn")
	)
	multiplayer.server_disconnected.connect(
		func():
			get_tree().change_scene_to_file("res://Scenes/Main/Menus/main.tscn")
	)
	
	
	
	
