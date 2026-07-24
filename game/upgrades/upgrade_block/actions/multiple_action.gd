class_name MultipleAction
extends UpgradeAction

var upgrades: Array[UpgradeAction] = []

func upgrade() -> void:
	for upgrade_action: UpgradeAction in upgrades:
		upgrade_action.upgrade()
