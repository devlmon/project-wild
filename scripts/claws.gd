extends Area2D

@export var speed = 15

func _ready():
	$AnimationPlayer.play("claws")

func _physics_process(delta):
	position += transform.x * speed * delta

func _on_body_entered(body: CharacterBody2D):
	body.enemy_hearts -= 1
	if body.enemy_hearts <= 0:
		SignalBus.score_increment.emit(5)
