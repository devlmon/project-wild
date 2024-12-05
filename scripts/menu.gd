extends Node2D
@onready var menu = $"."
var simultaneous_scene = preload("res://scenes/game.tscn").instantiate()

func _ready():
	SignalBus.end_game.connect(_on_end_game)

func _on_end_game():
	menu.visible = true
	SignalBus.restart_game.emit()
	get_tree().root.remove_child(simultaneous_scene)
	#get_node("res://scenes/game.tscn").free()


func _on_touch_screen_button_released():
	get_tree().root.add_child(simultaneous_scene)
	menu.visible = false
