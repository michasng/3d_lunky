class_name LevelGenerator
extends Node


@export var room_size: Vector3i = Vector3i(1, 1, 1)


func generate(grid_map: GridMap, grid_size: Vector3i):
	var path = _generate_critical_path(grid_size)
	var offset = Vector3i(10, 0, 0)
	for room in path:
		grid_map.set_cell_item(room + offset, 0)


func create_grid(grid_size: Vector3i) -> Array[Array]:
	var grid: Array[Array] = []
	for x in range(grid_size.x):
		grid.append([])
		for y in range(grid_size.y):
			grid[x].append(PackedInt32Array())
			for z in range(grid_size.z):
				grid[x][y].append(0)
	return grid


func _generate_critical_path(grid_size: Vector3i) -> Array[Vector3i]:
	var path: Array[Vector3i] = []
	var path_directions: Array[Vector3i] = []

	var entrance_room = Vector3i(randi_range(0, grid_size.x - 1), grid_size.y, randi_range(0, grid_size.z - 1))
	path.append(entrance_room)

	while true:
		var possible_directions = [Vector3i.DOWN]
		for direction in [Vector3i.LEFT, Vector3i.RIGHT, Vector3i.FORWARD, Vector3i.BACK]:
			var theoretical_room = path.back() + direction
			if theoretical_room.x < grid_size.x and theoretical_room.z < grid_size.z:
				possible_directions.append(direction)
		path_directions.append(possible_directions.pick_random())
		var target_room = path.back() + path_directions.back()
		if target_room.y < 0:
			break
		path.append(target_room)

	return path
