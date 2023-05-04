extends CharacterBody2D

const speed:int = 7000
var MovementEnabled:bool = true

func _ready():
	Engine.set_max_fps(120)
	EventBus.connect("AllowMovement", _allow_movement)

func _process(delta):
	# Movement
	var input_dir = Vector2(Input.get_action_strength("right") - Input.get_action_strength("left"), Input.get_action_strength("down") - Input.get_action_strength("up")).normalized()
	velocity = input_dir * (speed * delta)
	if MovementEnabled:
		move_and_slide()

func _allow_movement(Boolean):
	MovementEnabled = Boolean
