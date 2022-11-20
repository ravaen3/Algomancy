extends Area2D
const MAGNET_MAP = Vector2(90, 90)
const MAGNET_MAP_OFFSET = Vector2(0, 0)
var hidden_zone = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func format(bottom = false):
	for child in get_children():
		if child.is_in_group("Card"):
			child.position.x = round((child.position.x+MAGNET_MAP_OFFSET.x)/MAGNET_MAP.x)*MAGNET_MAP.x-MAGNET_MAP_OFFSET.x
			child.position.y = round((child.position.y+MAGNET_MAP_OFFSET.y)/MAGNET_MAP.y)*MAGNET_MAP.y-MAGNET_MAP_OFFSET.y
	pass
