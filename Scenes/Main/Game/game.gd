extends Node2D
var hand_scene = preload("res://Scenes/Main/Game/hand.tscn")
var player_id = 0
var phase_list = ["Draft","Combat","Main"]
var phase = "Draft"
var players_ready = []
var player_amount = 2
# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(0.2).timeout
	if multiplayer.is_server():
		var i = 1
		if Global.is_playing:
			set_player(i)
			i=2
		for peer in multiplayer.get_peers():
			rpc_id(peer, "set_player", i)
			i=2

@rpc
func set_player(id):
	player_id = id
	get_node("Player"+str(id)+"/Hand").hidden_zone = false
	get_node("Player"+str(id)+"/Pack").hidden_zone = false
	get_node("Player"+str(id)+"/Pack").visible = true
@rpc("any_peer")
func ready(id):
	if id in players_ready:
		pass
	else:
		players_ready.append(id)
		if players_ready.size() == player_amount:
			update_phase()
			rpc("update_phase")
			players_ready = []

@rpc
func update_phase():
	if phase == "Draft":
		print("Ending Draft Phase")
		var player1 = $Player1
		var player2 = $Player2
		var pack1 = player1.get_node("Pack")
		var pack2 = player2.get_node("Pack")
		var temp_pack = []
		for child in pack1.get_children():
			if child.is_in_group("Card"):
				pack1.remove_child(child)
				temp_pack.append(child)
		for child in pack2.get_children():
			if child.is_in_group("Card"):
				pack2.remove_child(child)
				pack1.add_child(child)
		for child in temp_pack:
			pack2.add_child(child)
		phase = "Combat"
	elif phase == "Combat":
		phase = "Main"
	elif phase == "Main":
		phase = "Draft"
			
func _process(delta):
	pass

func _on_move_mouse_entered():
	pass # Replace with function body.
