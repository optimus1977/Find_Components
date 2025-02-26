extends Node


var cpu = 0

func _process(delta: float) -> void:
	$CanvasLayer/Components.text = str(cpu)
