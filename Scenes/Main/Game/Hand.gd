extends Area2D

const CURVE_ORIGIN_DISTANCE = 2000
const CURVE_SIZE = 0.35

func _ready():
	format()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func format():
	var i = 0
	var selected_cards = []
	var curve_amount = CURVE_SIZE/get_child_count()
	if curve_amount > 0.04:
		curve_amount = 0.04
	for child in get_children():
		if child.is_in_group("Card"):
			child.rotation = (-curve_amount*get_child_count())+(2*curve_amount*(i+1))
			if child.hovering and child.global_position.y!=920:
				var tween = get_tree().create_tween()
				child.z_index = 64
				child.scale=Vector2(1.2,1.2)
				await tween.tween_property(child, "global_position:y", 920, 0.1).finished
				if not child.hovering:
					child.position = Vector2(0,CURVE_ORIGIN_DISTANCE)+Vector2(0,-CURVE_ORIGIN_DISTANCE).rotated(child.rotation)
					child.z_index = i
					child.scale=Vector2(1,1)
			else:
				child.position = Vector2(0,CURVE_ORIGIN_DISTANCE)+Vector2(0,-CURVE_ORIGIN_DISTANCE).rotated(child.rotation)
				child.z_index = i
				child.scale=Vector2(1,1)
			i=i+1
				
func activate():
	visible = true
	$Area.disabled = false

