class_name UpgradeBlock
extends PanelContainer

@export var upgrade_action: UpgradeAction

func _on_unlock_pressed() -> void:
	upgrade_action.upgrade()
