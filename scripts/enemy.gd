extends CharacterBody2D
class_name Enemy

@export var enemy_speed  := 30
@export var enemy_hearts := 1
@export var enemy_alive  := true
@onready var navigation_agent = $NavigationAgent2D
var target

func _ready() -> void:
	set_physics_process(false)
	call_deferred("wait_for_physics")
	
	SignalBus.player_node.connect(_on_player_node)
	SignalBus.restart_game.connect(_on_restart)
	
	target = get_node("Player")

func _on_restart():
	queue_free()

func _on_player_node(pnode):
	target = pnode
	
func wait_for_physics():
	await get_tree().physics_frame
	set_physics_process(true)

func _physics_process(_delta : float) -> void:
	if enemy_hearts <= 0:
		queue_free()
	
	navigation_agent.target_position = target.global_position
	velocity = global_position.direction_to(navigation_agent.get_next_path_position()) * enemy_speed
		
	move_and_slide()
