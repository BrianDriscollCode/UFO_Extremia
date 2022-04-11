extends Node2D

var missile_path = preload("res://actors/enemies/missile/missile.tscn")
var spawn_point_a
var spawn_point_b
var player_position

var all_spawn_locations = [spawn_point_a, spawn_point_b]
var spawn_holder = [0, 0]

func _physics_process(delta: float) -> void:
	#get_spawn_point_locations()
	get_player_position()


	
#func get_spawn_point_locations():
#	spawn_point_a = get_tree().get_current_scene().get_node("SpawnPointLeft").get_global_position()
#	spawn_point_b = get_tree().get_current_scene().get_node("SpawnPointRight").get_global_position()	
	
	
#func _on_SpawnMissile_timeout() -> void:
#	var missile = missile_path.instance()
#	add_child(missile)
	
#	var rng = RandomNumberGenerator.new()
#	rng.randomize()
#	var num = rng.randi_range(1, 2)
	
#	if num == 1:
#		missile.set_global_position(spawn_point_a)
#	else: 
#		missile.set_global_position(spawn_point_b)
		
func get_player_position():
	player_position = get_node("Player/Area2D/AnimatedSprite").get_global_position()
