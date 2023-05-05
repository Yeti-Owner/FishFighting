extends Control


func _ready():
	self.hide()
	EventBus.connect("UpdateFish", _update_inv)

func _on_texture_button_pressed():
	self.hide()

func _update_inv():
	for i in EventBus.Fish.size():
		get_node(str("Panel/MarginContainer/GridContainer/Panel" + str(i))).get_child(0).texture = load(str("res://assets/textures/fish" + str(EventBus.Fish[i]) + ".png"))
