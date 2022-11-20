extends Node2D
var selected = []
var players_ready = []
# Called when the node enters the scene tree for the first time.
func _ready():
	if multiplayer.is_server():
		$LobbyMenu/VBoxContainer/Playing.disabled = false
		$LobbyMenu/VBoxContainer/Playing.button_pressed = false
	else:
		$LobbyMenu/VBoxContainer/Playing.visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_back_pressed():
	Global.multiplayer_peer.close()
	get_tree().change_scene_to_file("res://Scenes/Main/Menus/main.tscn")


func _on_start_pressed():
	if multiplayer.is_server():
		Global.start_game("Draft",selected)
	else:
		rpc("player_ready", multiplayer.get_unique_id())
@rpc("any_peer")
func player_ready(peer_id):
	if multiplayer.is_server():
		players_ready.append(peer_id)
		if players_ready.size()>1:
			Global.start_game("Draft",selected)


@rpc("any_peer")
func select_item(index):
	var faction_list = $LobbyMenu/VBoxContainer/FactionList
	if faction_list.get_item_text(index) in selected:
		faction_list.set_item_icon(index,load("res://Assets/Icons/Cross.png"))
		selected.erase(faction_list.get_item_text(index))
	else:
		faction_list.set_item_icon(index,load("res://Assets/Icons/Check.png"))
		selected.append(faction_list.get_item_text(index))
	print(selected)

func _on_faction_list_item_selected(index):
	select_item(index)
	rpc("select_item", index)
