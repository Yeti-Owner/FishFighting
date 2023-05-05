extends Line2D

func _on_timer_timeout():
	add_point(get_parent().get_node("player").global_position)
	add_point((Vector2(get_parent().get_node("player").global_position + get_parent().get_node("Bobber").global_position)/2) - Vector2(0, 10))
	add_point(get_parent().get_node("Bobber").global_position)
