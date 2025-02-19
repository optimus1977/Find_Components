extends Control

func resume():
	hide()
	get_tree().paused = false

func pause():
	show()
	get_tree().paused = true

func testEsc():
	if Input.is_action_just_pressed("escape") and get_tree().paused == false:
		pause()
	elif Input.is_action_just_pressed("escape") and get_tree().paused == false:
		resume()

func _on_resume_button_pressed():
	hide()
	resume()


func _on_restart_button_pressed():
	resume()
	get_tree().reload_current_scene


func _on_quit_button_pressed():
	get_tree().quit()
	
func _process(delta):
	testEsc()
