extends Camera2D
var flipped = false
var anchor = position
var moving_camera = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("camera_move"):
		anchor = get_viewport().get_mouse_position()
		moving_camera = true
	if Input.is_action_just_released("camera_move"):
		moving_camera = false
	if moving_camera:
		self.global_position.x += anchor.x - get_viewport().get_mouse_position().x
		self.global_position.y += anchor.y - get_viewport().get_mouse_position().y
		anchor = get_viewport().get_mouse_position()
	if Input.is_action_pressed("camera_up"):
		if flipped:
			position.y+=10
		else:
			position.y-=10
	if Input.is_action_pressed("camera_down"):
		if flipped:
			position.y-=10
		else:
			position.y+=10
	if Input.is_action_pressed("camera_left"):
		if flipped:
			position.x+=10
		else:
			position.x-=10
	if Input.is_action_pressed("camera_right"):
		if flipped:
			position.x-=10
		else:
			position.x+=10
	if Input.is_action_just_released("zoom_in"):
		if zoom.x<1:
			zoom+=Vector2(0.05,0.05)
	if Input.is_action_just_released("zoom_out"):
		if zoom.x>0.5:
			zoom-=Vector2(0.05,0.05)
	if Input.is_action_just_released("flip_camera"):
		flipped = not flipped
		rotation+=deg_to_rad(180)
