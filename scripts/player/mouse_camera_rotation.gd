class_name MouseCameraRotation
extends Node


@export var camera: Camera3D

@export var mouse_sensitivity = 0.003


func _input(event: InputEvent):
	if Input.get_mouse_mode() != Input.MOUSE_MODE_CAPTURED:
		return

	if event is InputEventMouseMotion:
		camera.rotation.y -= event.relative.x * mouse_sensitivity
		camera.rotation.x -= event.relative.y * mouse_sensitivity
		camera.rotation.x = clamp(camera.rotation.x, -1.5, 1.5)
