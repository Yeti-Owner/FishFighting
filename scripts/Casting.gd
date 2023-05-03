extends Line2D

@onready var timer := get_node("CastTimer")
const auto_cast_time:int = 4
var bobber_timer = 0
var Casted:bool = false
var BobberRef

func _process(_delta):
	self.look_at(get_global_mouse_position())
	
	if Casted == false:
		if Input.is_action_just_pressed("cast"):
			timer.start(4)
		elif Input.is_action_just_released("cast"):
			_cast(timer.time_left)
			timer.stop()
			Casted = true
	else:
		if Input.is_action_just_pressed("cast"):
			BobberRef.queue_free()
			Casted = false
			timer.start(4)

func _cast(time):
	time = max(time, 1)
	var Distance = ($posStart.global_position - $posEnd.global_position)*(1/time)
	var bobber:PackedScene = load("res://scenes/bobber.tscn")
	var _bobber:Node = bobber.instantiate()
	get_parent().get_parent().add_child(_bobber)
	_bobber.global_position = ($posStart.global_position - Distance)
	
	BobberRef = _bobber
