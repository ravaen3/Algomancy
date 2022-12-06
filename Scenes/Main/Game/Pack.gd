extends Area2D
const MAGNET_MAP = Vector2(190, 140)
const MAGNET_MAP_OFFSET = Vector2(95, 0)
var hidden_zone = true
var selected = false
var select_point
var game
# Called when the node enters the scene tree for the first time.
func _ready():
	game = get_tree().root.get_node("Game")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if selected:
		position=get_global_mouse_position()-select_point
	pass

func format(bottom = false):
	for child in get_children():
		if child.is_in_group("Card"):
			child.position.x = round((child.position.x+MAGNET_MAP_OFFSET.x)/MAGNET_MAP.x)*MAGNET_MAP.x-MAGNET_MAP_OFFSET.x
			child.position.y = round((child.position.y+MAGNET_MAP_OFFSET.y)/MAGNET_MAP.y)*MAGNET_MAP.y-MAGNET_MAP_OFFSET.y
	pass
func _on_pass_pressed():
	if multiplayer.is_server():
		game.ready(game.player_id)
	else:
		game.rpc_id(1,"ready",game.player_id)

func _on_move_button_down():
	select_point = get_local_mouse_position().rotated(rotation)
	selected = true
	pass # Replace with function body.


func _on_move_button_up():
	selected = false
	pass # Replace with function body.
