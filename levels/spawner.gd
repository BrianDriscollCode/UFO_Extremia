extends Node2D

var current_number_of_abductees = 0
var total_abductees = 50
var abductee_path = preload("res://actors/people/abductee.tscn")

var current_position = Vector2(0,0)
var distance

func _ready() -> void:
	current_position = get_global_position()
	
func _physics_process(delta: float) -> void:
	
	if current_number_of_abductees < total_abductees:
		spawn_humans()
		current_number_of_abductees += 1
	
func spawn_humans():
	var abductee = abductee_path.instance()
	add_child(abductee)
	generate_random_distance()
	
	current_position.x = current_position.x + distance
	abductee.set_global_position(current_position)
	
func generate_random_distance():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	distance = rng.randi_range(5, 220)

	
