extends Node


var total_cpus: int = 0

#fuction to calculate the cpus collected
func cpus_collected(value:int):
	total_cpus += value
	EventController.emit_signal("cpu_collected", total_cpus)
