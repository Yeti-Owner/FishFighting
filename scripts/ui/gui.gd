extends CanvasLayer

@onready var timernode := get_parent().get_node("Casting").get_node("CastTimer")

func _process(delta):
	$Control/Label.text = str(EventBus.PlayerState)
	$Control/Label2.text = str(timernode.time_left)
