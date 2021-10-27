extends Control

const HistroyItem = preload("res://HistoryItem.tscn")

onready var histories = $GamePanel/GameMargin/PanelRows/ResponseArea/HistoryScroll/History
onready var scroll = $GamePanel/GameMargin/PanelRows/ResponseArea/HistoryScroll
onready var scrollbar = scroll.get_v_scrollbar()

var max_scroll_value := 0

export (int) var max_rows_remembered :=100

func _ready() -> void:
	scrollbar.connect("changed", self, "handle_scrollbar_changed")
	max_scroll_value = scrollbar.max_value

func handle_scrollbar_changed():
	if max_scroll_value != scrollbar.max_value:
		max_scroll_value = scrollbar.max_value
		scroll.scroll_vertical = max_scroll_value

func _on_Input_text_entered(input: String) -> void:
	if input.empty():
		return
	var history_item = HistroyItem.instance()
	history_item.set_text(input, "This is a response")
	histories.add_child(history_item)
	
	if histories.get_child_count() > max_rows_remembered:
		var rows_to_delete = histories.get_child_count() - max_rows_remembered
		for row in range(rows_to_delete):
			histories.get_child(row).queue_free()
