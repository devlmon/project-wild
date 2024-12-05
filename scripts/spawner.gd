extends Node2D

@export var enemy = preload("res://scenes/enemy.tscn")
@export var enemy_position = Vector2(0,0)
@onready var timer = $Timer

func _ready():
	SignalBus.restart_game.connect(_on_restart_game)
	
func _on_restart_game():
	timer.wait_time = 7

func _on_timer_timeout():
	var new_enemy    = enemy.instantiate()
	if timer.wait_time >= 1:
		timer.wait_time -= 0.25
	#var enemy_damage = damage.instantiate()
	new_enemy.global_position = enemy_position
	add_child(new_enemy)
	#new_enemy.add_child(enemy_damage)
