extends Area2D

@export var quest: Quest

var player_in_area = false
var cpu := load("res://scenes/cpu.tscn")

func _process(delta):
	if player_in_area:
		if Input.is_action_just_pressed("interact"):
			run_dialogue("TeacherCQuest")


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = true
		#if quest is available
		if quest.quest_status == quest.QuestStatus.available:
			#start quest
			quest.start_quest()
			#create a cpu to find
			var new_cpu = cpu.instantiate()
			add_child(new_cpu)
			#position cpu at spawn point
			new_cpu.position = $CpuSpawnPoint.position
			#set the quest in cpu
			new_cpu.quest = quest
			
		#if player has reached the goal
		if quest.quest_status == quest.QuestStatus.reached_goal:
			quest.finish_quest()


func _on_area_2d_body_exited(body):
	if body.has_method("player"):
		player_in_area = false


func run_dialogue(dialogue_string):
	Dialogic.start(dialogue_string)
	



