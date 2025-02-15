class_name Player extends CharacterBody2D

@onready var ray_cast_2d = $RayCast2D
const speed = 300.0
var player_state
var can_move = true
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	Global.player = self


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
	#turn raycast towards movement direction
	if velocity != Vector2.ZERO:
		ray_cast_2d.target_position = velocity.normalized() * 50

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

func _input(event):
	#interact with npc/ quest item
	if can_move:
		if event.is_action_pressed("interact"):
			var target = ray_cast_2d.get_collider()
			if target != null:
				if target.is_in_group("npc"):
					print("I am talking with an npc!")
					#to-do set can_move to false
					target.start_dialog()
				elif target.is_in_group("item"):
					print("I'm interacting with an item!")
					#to-do checking if item in needed for quest
					#to-do remove item
					target.start_interact()
