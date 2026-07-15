class_name CraftUnlock
extends UpgradeAction

@export var craft: Craft

func upgrade() -> void:
	craft.unlock()
