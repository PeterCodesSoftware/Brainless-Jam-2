class_name AreaUnlock
extends UpgradeAction

@export var area: Area

func upgrade() -> void:
	area.unlock_area()
