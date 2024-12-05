extends Label

@export var current_score := 0
@onready var score = $"."

func _ready():
	SignalBus.score_increment.connect(_on_score_increment)
	SignalBus.restart_game.connect(_on_restart)
	
func _on_restart():
	current_score = 0
	score.text = "0 SCORE"

func _on_score_increment(points):
	current_score += points
	print(current_score)
	score.text = str(current_score) + " SCORE"
	
