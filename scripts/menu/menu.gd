class_name Menu
extends Node


signal continue_requested


@export var continue_button: Button

@export var exit_button: Button


func _ready():
	continue_button.button_up.connect(on_continue_pressed)
	exit_button.button_up.connect(on_exit_pressed)


func on_continue_pressed():
	continue_requested.emit()


func on_exit_pressed():
	get_tree().quit()

