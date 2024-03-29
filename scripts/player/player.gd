class_name Player
extends CharacterBody3D


@export var level: Level


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var camera: Camera3D = $Camera3D


func _physics_process(delta: float):
	if Input.get_mouse_mode() != Input.MOUSE_MODE_CAPTURED:
		return

	if not is_on_floor():
		velocity.y -= gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction = get_flat_move_direction()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()


func get_view_direction() -> Transform3D:
	return camera.global_transform


func get_input_direction() -> Vector3:
	var input_dir_2d = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	return Vector3(input_dir_2d.x, 0, input_dir_2d.y)


func get_spatial_move_direction() -> Vector3:
	return (get_view_direction().basis * get_input_direction()).normalized()


func get_flat_move_direction() -> Vector3:
	var spatial_move_dir = get_spatial_move_direction()
	return Vector3(spatial_move_dir.x, 0, spatial_move_dir.z).normalized()

