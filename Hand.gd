extends Area2D
var hidden_zone = true
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func format(bottom = false):
	var i = 0
	for child in get_children():
		if child.is_in_group("Card"):
			child.rotation = 0
			child.position = $Pivot.position
			child.position += Vector2(0,-$Pivot.position.y).rotated(child.rotation)
			++i
	pass
