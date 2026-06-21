extends Control

signal to_page_1()

func _on_switch_menu_pressed():
	to_page_1.emit()
