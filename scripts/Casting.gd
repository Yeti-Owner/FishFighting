extends Line2D

@onready var timer := get_node("CastTimer")
var bobber_timer = 0
var Cast:bool = false

func _process(_delta):
	self.look_at(get_global_mouse_position())
	
	if EventBus.PlayerState == 0:
		if Input.is_action_just_pressed("cast"):
			timer.start()
			print("started")
		if Input.is_action_just_released("cast"):
			_cast(timer.time_left)
	elif EventBus.PlayerState == 1:
		if Input.is_action_just_released("cast"):
			EventBus.PlayerState = 0

func _cast(time):
	timer.stop()
	time = max(time, 1)
	var Distance = ($posStart.global_position - $posEnd.global_position)*(1/time)
	var bobber:PackedScene = load("res://scenes/bobber.tscn")
	var _bobber:Node = bobber.instantiate()
	get_parent().get_parent().add_child(_bobber)
	_bobber.global_position = ($posStart.global_position - Distance)
