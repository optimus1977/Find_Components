extends Control

@onready var label = $Label

func _ready():
	EventController.connect("cpu_collected", on_event_cpus_collected)

#assigning the value to label
func  on_event_cpus_collected(value: int) -> void:
	label.text = str(value)

