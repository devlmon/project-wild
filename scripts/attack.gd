extends TouchScreenButton

#UP
func _on_up_pressed():
	SignalBus.direction_attack.emit("UP")
	
#LEFT
func _on_left_pressed():
	SignalBus.direction_attack.emit("LEFT")
	
#RIGHT
func _on_right_pressed():
	SignalBus.direction_attack.emit("RIGHT")
	
#DOWN
func _on_down_pressed():
	SignalBus.direction_attack.emit("DOWN")
