extends Control

var questions = [
	{
		"question": "Which component is considered the brain of the computer?",
		"choices": ["RAM", "CPU", "GPU", "HDD"],
		"correct": 1  # CPU
	},
	{
		"question": "Which component stores long-term data?",
		"choices": ["RAM", "SSD", "CPU", "PSU"],
		"correct": 1  # SSD
	},
	{
		"question": "What does GPU stand for?",
		"choices": ["Graphics Processing Unit", "General Power Unit", "Game Processing Utility", "Graphical Peripheral Unit"],
		"correct": 0  # Graphics Processing Unit
	},
	{
		"question": "Which component provides power to all other parts?",
		"choices": ["Motherboard", "Power Supply Unit", "Cooling Fan", "RAM"],
		"correct": 1  # Power Supply Unit (PSU)
	},
	{
		"question": "Which component affects gaming performance the most?",
		"choices": ["HDD", "RAM", "GPU", "CPU"],
		"correct": 2  # GPU
	},
	{
		"question": "What is the purpose of RAM?",
		"choices": ["Store permanent files", "Improve internet speed", "Provide temporary data storage for quick access", "Control power usage"],
		"correct": 2  # Provide temporary data storage
	},
	{
		"question": "Which port is commonly used for high-speed external storage?",
		"choices": ["USB-C", "VGA", "Ethernet", "HDMI"],
		"correct": 0  # USB-C
	},
	{
		"question": "What does BIOS stand for?",
		"choices": ["Basic Input Output System", "Binary Internal Operating System", "Basic Integrated Operating Structure", "Built-In Operating Software"],
		"correct": 0  # Basic Input Output System
	},
	{
		"question": "Which component connects all the other parts of a PC together?",
		"choices": ["CPU", "GPU", "Motherboard", "RAM"],
		"correct": 2  # Motherboard
	},
	{
		"question": "Which storage device is the fastest?",
		"choices": ["HDD", "SSD", "DVD", "Flash Drive"],
		"correct": 1  # SSD
	}
]

var current_question_index = 0
var score = 0
var shuffled_choices = []
var correct_index = 0  # Stores correct index after shuffle

@onready var question_label = $QuestionLabel
@onready var vbox_container = $VBoxContainer
@onready var buttons = vbox_container.get_children()
@onready var playgame_label = $PlayGameLabel
@onready var feedback_label = $FeedbackLabel
@onready var score_label = $ScoreLabel
@onready var next_button = $PlayGame  # The "Next" button

func _ready():
	playgame_label.visible = false
	next_button.visible = false  # Hide next button at start
	load_question()

func load_question():
	var q = questions[current_question_index]
	question_label.text = q["question"]

	# Get original choices and correct answer
	var original_choices = q["choices"].duplicate()
	var correct_answer_text = original_choices[q["correct"]]

	# Shuffle answers while keeping track of the correct one
	shuffled_choices = original_choices.duplicate()
	shuffled_choices.shuffle()
	correct_index = shuffled_choices.find(correct_answer_text)  # Find new correct index

	# Assign shuffled answers to buttons
	for i in range(len(buttons)):
		buttons[i].text = shuffled_choices[i]
		
		# Disconnect to prevent duplicate connections
		if buttons[i].is_connected("pressed", _on_answer_selected):
			buttons[i].disconnect("pressed", _on_answer_selected)

		# Connect each button press to the function
		buttons[i].pressed.connect(_on_answer_selected.bind(i))

	feedback_label.text = ""
	update_score_display()

func _on_answer_selected(choice_index):
	if choice_index == correct_index:  # ✅ Now comparing with correct_index
		feedback_label.text = " Correct!"
		score += 1
	else:
		feedback_label.text = " Wrong! Try again."

	update_score_display()

	await get_tree().create_timer(1.5).timeout
	next_question()

func next_question():
	current_question_index += 1

	if current_question_index < questions.size():
		load_question()
	else:
		end_quiz()

func update_score_display():
	score_label.text = "Score: %d" % score

func end_quiz():
	update_score_display()
	question_label.text = "🎉 Quiz Completed!"
	feedback_label.text = "Final Score: %d/%d" % [score, questions.size()]
	playgame_label.text = "Press play game to continue!"
	for button in buttons:
		button.visible = false

	next_button.visible = true  # Show the "Next" button
	playgame_label.visible = true

# When the next button is clicked, you can restart or load another scene
func _on_play_game_pressed():
	get_tree().change_scene_to_file("res://scenes/level_1.tscn")
