class_name Level
extends Node


@onready var grid_map: GridMap = $GridMap
@onready var level_generator: LevelGenerator = $LevelGenerator


func _ready():
	level_generator.generate(grid_map, Vector3i(5, 5, 5))


# func _pick_block(position):
# 	grid_map.get_cell_item()

