class_name AreaUnlock
extends UpgradeAction

@export var area_name: String

func upgrade() -> void:
	GM.unlock_area.emit(area_name)
