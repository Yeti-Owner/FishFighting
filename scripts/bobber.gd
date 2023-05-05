extends Node2D

const WATER_AREA_NAME = "WaterArea"
const MIN_SPAWN_TIME = 3
const MAX_SPAWN_TIME = 10

@onready var anim_player = $AnimationPlayer
@onready var Area = $Area2D
@onready var catch_timer = $CatchTimer
@onready var struggle_timer = $StruggleTimer

var overlapping_areas = []
var StringRef

func _ready():
	randomize()
	var string:PackedScene = load("res://scenes/string.tscn")
	var _string:Node = string.instantiate()
	get_parent().add_child(_string)
	StringRef = _string

@warning_ignore("unused_parameter")
func _physics_process(delta):
	if Input.is_action_pressed("cast") && EventBus.PlayerState == 1:
		_catch()

func _on_timer_timeout():
	overlapping_areas = Area.get_overlapping_areas()
	if overlapping_areas.size() <= 0:
		_reset()
	else:
		for area in overlapping_areas:
			if area.name == WATER_AREA_NAME:
				EventBus.PlayerState = 1
				EventBus.AllowMovement.emit(false)
				self.show()
				anim_player.play("idle")
				catch_timer.wait_time = randf_range(MIN_SPAWN_TIME, MAX_SPAWN_TIME)
				catch_timer.start()

func _on_catch_timer_timeout():
	anim_player.play("struggle", 0.25)
	struggle_timer.start()

func _on_struggle_timer_timeout():
	_reset()

func _catch():
	if struggle_timer.is_stopped():
		_reset()
	else:
		if EventBus.Fish.size() <= 5:
			EventBus.Fish.append(randi() % 3 + 1)
			EventBus.emit_signal("UpdateFish")
		_reset()

func _reset():
	EventBus.AllowMovement.emit(true)
	self.queue_free()
	StringRef.queue_free()
