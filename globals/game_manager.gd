extends Node

signal goslings_available_changed

var goslings_available: int = 1:
	set(value):
		goslings_available = value
		goslings_available_changed.emit()
