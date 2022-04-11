extends AnimatedSprite

var player_position
var turret_position
var missile_path = preload("res://actors/enemies/missile/missile.tscn")

var distance_from_player
var is_on_screen = false

func _ready() -> void:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var num = rng.randi_range(8, 15)
	$spawnRocketTimer.set_wait_time(num)
	$spawnRocketTimer.start()

func _physics_process(delta: float) -> void:
	get_player_and_turret_position()
	decide_turret_direction()
	get_distance_from_player()
	
func spawn_rocket():
	var missile = missile_path.instance()
	add_child(missile)
	missile.set_global_position(turret_position)
	
	
func get_distance_from_player():
	
	var higher
	var lower 
	
	if player_position.x > turret_position.x:
		higher = player_position.x
		lower = turret_position.x
	else:
		higher = turret_position.x
		lower = player_position.x
		
	
	distance_from_player = higher - lower
	
	
func decide_turret_direction():
	if player_position.x > turret_position.x + 10:
		set_frame(2)
	elif player_position.x < turret_position.x - 10: 
		set_frame(0)
	else:
		set_frame(1)
	
func get_player_and_turret_position():
	player_position = get_tree().get_current_scene().get_node("Player/Area2D/AnimatedSprite").get_global_position()
	turret_position = position


func _on_spawnRocketTimer_timeout() -> void:
	
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var num = rng.randi_range(8, 15)
	$spawnRocketTimer.set_wait_time(num)
	$spawnRocketTimer.start()
	
	if is_on_screen:
		spawn_rocket()


func _on_VisibilityNotifier2D_screen_entered() -> void:
	is_on_screen = true


func _on_VisibilityNotifier2D_screen_exited() -> void:
	is_on_screen = false
