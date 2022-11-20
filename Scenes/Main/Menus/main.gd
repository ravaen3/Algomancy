extends Node2D

func _ready():
	multiplayer.connected_to_server.connect(
		func():
			$StartMenu/Error.text= "Network Error: Could not connect to server"
			var tween = get_tree().create_tween()
			$StartMenu/Error.modulate.a = 1
			tween.tween_property($StartMenu/Error, "modulate:a", 0, 2)
	)


func _on_host_game_pressed():
	var port = $StartMenu/VBoxContainer/PortInput.text.to_int()
	Global.host_server(port)

func _on_join_game_pressed():
	var port = $StartMenu/VBoxContainer/PortInput.text.to_int()
	Global.join_server($StartMenu/VBoxContainer/IpInput.text,port)


func _on_quit_game_pressed():
	pass # Replace with function body.
