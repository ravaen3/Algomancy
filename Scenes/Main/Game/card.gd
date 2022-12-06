extends Area2D
var power
var toughness
var threshold
var cost
var type
var text
var imageURL
var details
var factions
var default_texture

var selected = false
var origin = position

var game
var cursor
func _ready():
	game = get_tree().root.get_node("Game")
	var card = Global.cards.get(str(name))[0]
	power = card.power
	toughness = card.toughness
	threshold = card.cost
	cost = card.total_cost
	type = card.type
	text = card.text
	factions = card.factions
	imageURL = str(card.name).replace(" ","-")+".jpg"
	if FileAccess.file_exists("res://Assets/Cards/Art/"+imageURL):
		default_texture = load("res://Assets/Cards/Art/"+imageURL)
	else:
		$CardArtImporter.request("https://calebgannon.com/wp-content/uploads/cardsearch-images/"+imageURL)
	update()

func update():
	if get_parent().hidden_zone:
		$Art.texture_normal = load("res://Assets/Cards/Card-Back.jpg")
		$Art.tooltip_text = text
	else:
		$Art.texture_normal = default_texture
		$Art.tooltip_text = text

func _on_card_art_importer_request_completed(result, response_code, headers, body):
	if result == HTTPRequest.RESULT_SUCCESS:
		var image = Image.new()
		image.load_jpg_from_buffer(body)
		if !image.is_empty():
			var texture = ImageTexture.create_from_image(image)
			default_texture = texture
			var file = FileAccess.open("res://Assets/Cards/Art/"+imageURL,FileAccess.WRITE)
			file.store_buffer(body)
			file = null
		else:
			default_texture = load("res://Assets/Cards/Place-Holder.jpg")
	else:
		default_texture = load("res://Assets/Cards/Place-Holder.jpg")
	update()

func _on_art_button_down():
	rpc("set_disabled")
	cursor = game.get_node("Cursor")
	cursor.get_node("SelectedImage").texture = $Art.texture_normal
	origin = position
	selected = true
	pass # Replace with function body.



@rpc("any_peer")
func set_disabled(disable = true):
	$Art.disabled = disable
	
@rpc("any_peer")
func update_card_location(pos, rot, path_to_area, bottom):
	var area = game.get_node(path_to_area)
	var old_parent = get_parent()
	get_parent().remove_child(self)
	area.add_child(self)
	global_position=pos
	rotation = rot
	update()
	get_parent().format(bottom)
	old_parent.format()
func format():
	pass

func _on_art_button_up():
	cursor = game.get_node("Cursor")
	cursor.get_node("SelectedImage").texture = null
	selected = false
	rpc("set_disabled", false)
	global_position = Global.get_global_mouse_position()
	var move = false
	if game.player_id:
		var area = cursor.get_overlapping_areas().back()
		if area != null:
			if area != self and !move:
				var bottom = false
				move = true
				if Input.is_action_pressed("shift"):
					bottom = true
				if area != get_parent():
					print("Player "+str(game.player_id)+" moved "+ str(name)+" to " + str(area.name))
				rpc("update_card_location", Global.get_global_mouse_position(), rotation, game.get_path_to(area), bottom)
				update_card_location(Global.get_global_mouse_position(), rotation, game.get_path_to(area), bottom)
	if !move:
		position = origin


func _on_art_mouse_entered():
	$Hover.visible = true
	pass # Replace with function body.


func _on_art_mouse_exited():
	$Hover.visible = false
	pass # Replace with function body.
