extends TextureButton


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _make_custom_tooltip(text):
	var tooltip = preload("res://Scenes/Main/Game/card_tooltip.tscn").instantiate()
	tooltip.get_node("Label").text = text
	return tooltip
