extends CharacterBody2D

@onready var AnimPlayer := $AnimationPlayer
const speed:int = 7000
var MovementEnabled:bool = true
var input_dir

func _ready():
	Engine.set_max_fps(120)
	EventBus.connect("AllowMovement", _allow_movement)

func _process(delta):
	# Movement
	input_dir = Vector2(Input.get_action_strength("right") - Input.get_action_strength("left"), Input.get_action_strength("down") - Input.get_action_strength("up")).normalized()
	velocity = input_dir * (speed * delta)
	if MovementEnabled:
		move_and_slide()
	
	# Animation
	if input_dir == Vector2.ZERO:
		AnimPlayer.play("idle", 0.5)
	elif input_dir == Vector2.LEFT:
		AnimPlayer.play("left", 0.5)
	elif input_dir == Vector2.RIGHT:
		AnimPlayer.play("right", 0.5)
	elif input_dir == Vector2.UP:
		AnimPlayer.play("up", 0.5)
	elif input_dir == Vector2.DOWN:
		AnimPlayer.play("down", 0.5)
	

func _allow_movement(Boolean):
	MovementEnabled = Boolean
