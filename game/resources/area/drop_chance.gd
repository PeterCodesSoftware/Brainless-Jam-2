class_name DropChance
extends Resource


@export var min_drop: int
@export var max_drop: int

func get_drop() -> int:
	var diff: int = max_drop - min_drop
	return min_drop + round(randf_range(0, diff))
