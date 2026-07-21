extends Control

const AREA_SLOT = preload("uid://dcngkhjtt3gm0")

const AREAS_PATH: String = "res://game/resources/area/areas/"

@onready var available_goslings_label: Label = %AvailableGoslingsLabel
@onready var area_container: GridContainer = %AreaContainer

func _ready() -> void:
	GM.goslings_available_changed.connect(update_gosling_label)
	
	for area_path: String in DirAccess.get_files_at(AREAS_PATH):
		var area_slot: AreaSlot = AREA_SLOT.instantiate()
		area_slot.area = load(AREAS_PATH + area_path)
		area_container.add_child(area_slot)

func update_gosling_label() -> void:
	available_goslings_label.text = str(GM.goslings_available) + " gosling" + ("s" if GM.goslings_available != 1 else "") + " ready to work"
