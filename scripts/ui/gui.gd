extends CanvasLayer

func _on_button_pressed():
	$Control/Inventory.show()
	EventBus.emit_signal("UpdateFish")

func _process(delta):
	$Control/ProgressBar.value = 4 - get_parent().get_node("Casting/CastTimer").time_left
