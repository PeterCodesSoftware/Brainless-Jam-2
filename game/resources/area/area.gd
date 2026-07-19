class_name Area
extends Resource

signal unlock

@export var resources: Dictionary[Item, DropChance] = {}
@export var texture: Texture2D
@export var time_to_drop: float = 10

func unlock_area() -> void:
	unlock.emit()
