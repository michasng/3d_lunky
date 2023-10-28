class_name GridMapRayCast
extends Node


@export var camera: Camera3D

@export var body: CharacterBody3D

@export var ray_length: float = 5


func _input(event: InputEvent):
	if Input.get_mouse_mode() != Input.MOUSE_MODE_CAPTURED:
		return

	var crosshair_position = camera.get_window().size / 2
	var ray_start = camera.project_ray_origin(crosshair_position)
	var ray_dir = camera.project_ray_normal(crosshair_position)
	var ray_end = ray_start + ray_dir * ray_length

	var intersect_ray_params = PhysicsRayQueryParameters3D.create(ray_start, ray_end, 0xFFFFFFFF, [body.get_rid()])
	var space_state = body.get_world_3d().direct_space_state
	var result = space_state.intersect_ray(intersect_ray_params)

	if not result or not is_instance_of(result.collider, GridMap):
		return

	var grid_map = (result.collider as GridMap)
	var normal_offset = grid_map.cell_size / 2 * result.normal
	var cell_world_position: Vector3 = result.position - normal_offset
	var empty_world_position: Vector3 = result.position + normal_offset

	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			var cell_position = grid_map.local_to_map(cell_world_position)
			grid_map.set_cell_item(cell_position, GridMap.INVALID_CELL_ITEM)
		if event.button_index == MOUSE_BUTTON_RIGHT:
			var empty_position = grid_map.local_to_map(empty_world_position)
			grid_map.set_cell_item(empty_position, 0)
