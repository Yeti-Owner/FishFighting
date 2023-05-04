extends Node2D

@onready var AnimPlayer := $AnimationPlayer
@onready var Area := $Area2D
@onready var CatchTimer := $CatchTimer
@onready var StruggleTimer := $StruggleTimer

func _ready():
	randomize()

@warning_ignore("unused_parameter")
func _physics_process(delta):
	if Input.is_action_just_pressed("cast") && EventBus.PlayerState == 1:
		_catch()

func _on_area_2d_area_entered(area):
	if area.name == "WaterArea":
		EventBus.AllowMovement.emit(false)

func _on_timer_timeout():
	if Area.get_overlapping_areas().size() <= 0:
		self.queue_free()
		EventBus.AllowMovement.emit(true)
	else:
		for area in Area.get_overlapping_areas():
			if area.name == "WaterArea":
				EventBus.PlayerState = 1
				EventBus.AllowMovement.emit(false)
				self.show()
				AnimPlayer.play("idle")
				CatchTimer.wait_time = (randi() % 8 + 3)
				CatchTimer.start()

func _on_catch_timer_timeout():
	AnimPlayer.play("struggle", 0.25)
	StruggleTimer.start()

func _on_struggle_timer_timeout():
	self.queue_free()
	EventBus.AllowMovement.emit(true)

func _catch():
	if StruggleTimer.is_stopped():
		EventBus.AllowMovement.emit(true)
		self.queue_free()
	else:
		print("Caught!")
		EventBus.AllowMovement.emit(true)
		self.queue_free()


