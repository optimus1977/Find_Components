class_name Player extends CharacterBody2D


const speed = 300.0
var player_state

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	#move player 
	var direction = Input.get_vector("left", "right", "up", "down")
	
	if direction.x == 0 and direction.y == 0:
		player_state = "idle"
	elif direction.x != 0 or direction.y != 0:
		player_state = "walking"
		
	velocity = direction * speed
	move_and_slide()
	#play the correct animation
	play_anim(direction)

func play_anim(dir):
	if player_state == "idle":
		$AnimatedSprite2D.play("idle")
	if player_state == "walking":
		if dir.y == -1:
			$AnimatedSprite2D.play("move_up")
		if dir.x == 1:
			$AnimatedSprite2D.play("move_right")
		if dir.y == 1:
			$AnimatedSprite2D.play("move_down")
		if dir.x == -1:
			$AnimatedSprite2D.play("move_left")
