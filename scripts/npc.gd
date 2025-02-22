extends CharacterBody2D


var player_in_area = false

func _process(delta):
	if player_in_area:
		if Input.is_action_just_pressed("interact"):
			run_dialogue("TeacherCQuest")


func _on_area_2d_body_entered(body):
	if body.has_method("player"):
		player_in_area = true


func _on_area_2d_body_exited(body):
	if body.has_method("player"):
		player_in_area = false


func run_dialogue(dialogue_string):
	Dialogic.start(dialogue_string)
	
