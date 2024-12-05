extends Area2D

@onready var joystick_range = $Range
@onready var stick = $Stick
@onready var joystick = $"."
@onready var radius = $CollisionShape2D.shape.radius
@onready var distance : float
@onready var direction : Vector2
var index = -1

func _physics_process(_delta):
	SignalBus.joystick_input.emit(joystick)

func _input(event):
	if event is InputEventScreenTouch:
		if event.is_pressed() and index == -1:
			distance = global_position.distance_to(event.position)
			if distance < radius:
				index = event.index
				stick.global_position = event.position
				direction = global_position.direction_to(stick.global_position) * distance / radius
				direction = direction.snapped(Vector2(1,1))
		elif event.index == index:
			index = -1
			stick.position = Vector2.ZERO
			direction = Vector2.ZERO
		
	if event is InputEventScreenDrag:
		if event.index == index:
			distance = global_position.distance_to(event.position)
			if distance <= radius:
				stick.global_position = event.position
				direction = (global_position.direction_to(stick.global_position) * distance) / radius
				direction = direction.snapped(Vector2(1,1))
			else:
				direction = global_position.direction_to(event.position)
				direction = direction.snapped(Vector2(1,1))
				stick.position = direction * radius
