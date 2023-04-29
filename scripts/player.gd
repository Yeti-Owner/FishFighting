extends CharacterBody2D

var speed:int = 150

func _physics_process(_delta):
	var input_dir = Vector2(Input.get_action_strength("right") - Input.get_action_strength("left"), Input.get_action_strength("down") - Input.get_action_strength("up")).normalized()
	velocity = input_dir * speed
	move_and_slide()
