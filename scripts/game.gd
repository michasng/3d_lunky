class_name Game
extends Node


var menu: Menu = preload("res://scenes/menu/menu.tscn").instantiate()


func _ready():
	menu.continue_requested.connect(_close_menu)


func _input(event: InputEvent):
	if event is InputEventKey and event.keycode == KEY_ESCAPE and not _is_menu_open():
		_open_menu()


func _is_menu_open():
	return menu.get_parent() == self


func _open_menu():
	add_child(menu)
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func _close_menu():
	remove_child(menu)
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

