extends CharacterBody2D

var speed:int = 7000

func _ready():
	Engine.set_max_fps(120)

func _process(delta):
	# Movement
	var input_dir = Vector2(Input.get_action_strength("right") - Input.get_action_strength("left"), Input.get_action_strength("down") - Input.get_action_strength("up")).normalized()
	velocity = input_dir * (speed * delta)
	move_and_slide()
