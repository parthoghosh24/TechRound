extends MarginContainer

func set_text(input: String, response: String) -> void:
	$HistoryItem/InputHistory.text= " > "+input
	$HistoryItem/Response.text= response
