class_name AreaSlot
extends PanelContainer

const GOSLING_IMG = preload("uid://3noa1gmpsx54")
const AREA_DISPLAY = preload("uid://w6u1nasagkn6")

@onready var gosling_container: GridContainer = %GoslingContainer
@onready var add_gosling: Button = %AddGosling
@onready var remove_gosling: Button = %RemoveGosling
@onready var drop_bar: ProgressBar = %DropBar

var area: Area

var locked: bool = true

const max_goslings: int = 9
var working_goslings: int = 0
var is_drop_bar_active: bool = false

signal display_area_info(node: Node)

func _ready() -> void:
	area.unlock.connect(unlock)
	%AreaIMG.texture = area.texture
	%Name.text = area.name
	
	unlock()

func _process(delta: float) -> void:
	if not is_drop_bar_active:
		return
	
	drop_bar.value += (1 / area.time_to_drop) * delta
	if drop_bar.value >= 1:
		drop_bar.value = 0
		collect_drops()

func collect_drops() -> void:
	for item: Item in area.resources.keys():
		GM.add_item(item, area.resources[item].get_drop(working_goslings))

func unlock() -> void:
	if not locked:
		return
	
	locked = false
	add_gosling.disabled = false
	remove_gosling.disabled = false
	%LockIMG.queue_free()

func _on_add_gosling_pressed() -> void:
	if GM.goslings_available == 0:
		return
	
	GM.goslings_available -= 1
	working_goslings += 1
	gosling_container.add_child(GOSLING_IMG.instantiate())
	remove_gosling.disabled = false
	if working_goslings == max_goslings:
		add_gosling.disabled = true
	
	if working_goslings == 1:
		start_progress_bar()

func _on_remove_gosling_pressed() -> void:
	GM.goslings_available += 1
	working_goslings -= 1
	remove_last_child(gosling_container)
	add_gosling.disabled = false
	if working_goslings == 0:
		remove_gosling.disabled = true
	
	if working_goslings == 0:
		stop_progress_bar()

func start_progress_bar() -> void:
	is_drop_bar_active = true

func stop_progress_bar() -> void:
	is_drop_bar_active = false
	drop_bar.value = 0

func remove_last_child(node: Node) -> void:
	node.remove_child(node.get_child(node.get_child_count() - 1))


func _on_info_button_pressed() -> void:
	var area_display: AreaDisplay = AREA_DISPLAY.instantiate()
	push_warning("NOT IMPLEMENTED YET")
	display_area_info.emit()
