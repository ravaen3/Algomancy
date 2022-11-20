extends Node




func update_cards():
	var request = $JSONImporter.request("https://calebgannon.com/wp-content/uploads/algomancy-extras/AlgomancyCards.json")
	if request != OK:
		push_error("An error occurred in the HTTP request.")
	else:
		print(request)

func _on_json_importer_request_completed(result, response_code, headers, body):
	var json = JSON.new()
	var file = FileAccess.open("res://Assets/Cards/cards.json", FileAccess.WRITE)
	file.store_string(body.get_string_from_utf8())
