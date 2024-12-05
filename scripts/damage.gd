extends Area2D
@onready var enemy = $".."

func _on_body_entered(body: CharacterBody2D):
	SignalBus.impact.emit()
	body.hearts -= 1
	enemy.enemy_hearts -= 1
