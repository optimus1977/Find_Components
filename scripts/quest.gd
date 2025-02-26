class_name Quest extends QuestManager

#start the quest
func start_quest() -> void:
	#make sure this quest is available to start
	if quest_status == QuestStatus.available:
		#update quest status
		quest_status = QuestStatus.started
		#update ui
		QuestBox.visible = true
		QuestTitle.text = quest_name
		QuestDescription.text = quest_description

#mark goal reached
func reached_goal() -> void:
	if quest_status == QuestStatus.started:
		#update quest status
		quest_status = QuestStatus.reached_goal
		#update ui
		QuestDescription.text = reached_goal_text
		
#finish the quest
func finish_quest() -> void:
	if quest_status == QuestStatus.reached_goal:
		#update quest status
		quest_status = QuestStatus.finished
		
		#update ui
		QuestBox.visible = false
