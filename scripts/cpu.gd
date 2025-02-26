extends Area2D

var quest: Quest

@export var value: int = 1

func _on_body_entered(body):
	if body is Player:
		quest.reached_goal()
		queue_free()
