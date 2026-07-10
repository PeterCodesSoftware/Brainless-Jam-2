class_name DropChance
extends Resource


@export var min_drop: int
@export var max_drop: int

func get_drop(multiplier: int) -> int:
	var diff: int = max_drop - min_drop
	return min_drop * multiplier + round(randf_range(0, diff * multiplier))
