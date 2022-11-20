extends Button
var minimized = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	for child in get_children():
		child.visible = minimized
	minimized = not minimized
	
	pass # Replace with function body.
