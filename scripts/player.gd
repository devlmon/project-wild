extends CharacterBody2D
class_name Player
# player attributes

signal defeat

enum powers {CLAWS, FIRE, DREAM}
@export var power       : powers
@export var player_name : String
@export var hearts      := 3
@export var speed       := 65.0
@export var power_scene : PackedScene
var knockback = false
@export var knockback_resistance: float = 0.1
var knockback_force = Vector2.ZERO
@onready var pnode = $"."
var direction : Vector2

func _ready():
	SignalBus.restart_game.connect(_on_restart_game)
	SignalBus.joystick_input.connect(_on_movement)
	SignalBus.direction_attack.connect(_on_power_attack)

func _on_restart_game():
	hearts = 3
	pnode.position = Vector2(65,-7)
	direction = Vector2.ZERO

func _process(_delta):
	if hearts <= 0:
		print("You have been defeated!")
		defeat.emit()
		
	
func _on_defeat():
	# The player is defeated so the game ends.
	print("OH NO!")
	#get_tree().reload_current_scene()
	SignalBus.end_game.emit()


func _on_movement(joystick):
	direction = joystick.direction
	direction.normalized()

func _physics_process(delta : float) -> void:
	# normalize direction speed
	if direction.length() > 1.0:
		direction = direction.normalized()
	
	# velocity calculation and fuction call
	velocity = speed * direction
	
	
	knockback_force = knockback_force.move_toward(Vector2.ZERO, knockback_resistance)
	if knockback == true:
		velocity += knockback_force * delta
		global_position += velocity
		knockback = false

	
	
	move_and_slide()
	SignalBus.player_node.emit(pnode)
	
	
func _on_power_attack(attack_direction):
	
	if attack_direction == "RIGHT":
		$AttackMarker.position.x = 15
		$AttackMarker.position.y = 0
		$AttackMarker.rotation_degrees = 0
		shoot()
	elif attack_direction == "LEFT":
		$AttackMarker.position.x = -15
		$AttackMarker.position.y = 0
		$AttackMarker.rotation_degrees = 180
		shoot()
	elif attack_direction == "DOWN":
		$AttackMarker.position.y = 15
		$AttackMarker.position.x = 0
		$AttackMarker.rotation_degrees = 90
		shoot()
	elif attack_direction == "UP":
		$AttackMarker.position.y = -15
		$AttackMarker.position.x = 0
		$AttackMarker.rotation_degrees = 270
		shoot()
		
func shoot():
	var actual_power = power_scene.instantiate()
	get_tree().root.add_child(actual_power)
	actual_power.transform = $AttackMarker.global_transform
