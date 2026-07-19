@tool
class_name DropChance
extends Resource

@export var min_drop: int:
	set(value):
		min_drop = value
		if max_drop < min_drop:
			max_drop = min_drop
@export var max_drop: int:
	set(value):
		max_drop = value
		if min_drop > max_drop:
			min_drop = max_drop

func get_drop(multiplier: int) -> int:
	var diff: int = max_drop - min_drop
	return min_drop * multiplier + round(randf_range(0, diff * multiplier))
