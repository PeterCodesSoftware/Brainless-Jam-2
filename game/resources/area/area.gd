class_name Area
extends Resource

@export var name: String = ""
@export var resources: Dictionary[Item, DropChance] = {}
@export var texture: Texture2D
@export var time_to_drop: float = 10

signal unlock

func unlock_area() -> void:
	unlock.emit()
