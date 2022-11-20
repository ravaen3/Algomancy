extends ItemList

var selected = []

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_item_selected(index):
	if multiplayer.is_server():
		select_item(index)
		rpc("select_item", index)

@rpc("any_peer")
func select_item(index):
	if get_item_text(index) in selected:
		set_item_icon(index,load("res://Assets/Icons/Cross.png"))
		selected.erase(get_item_text(index))
	else:
		set_item_icon(index,load("res://Assets/Icons/Check.png"))
		selected.append(get_item_text(index))
	print(selected)
