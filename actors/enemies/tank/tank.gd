extends AnimatedSprite

var player_position = 0
var tank_position = 0
var shell_path =  preload("res://actors/enemies/tank/shell.tscn")
var number_of_shells = 0

var has_fired = false
var on_screen = false

func _physics_process(delta: float) -> void:
	get_player_position()
	get_tank_position()
	decide_facing_direction()
	shoot()
	
	#print(player_position, "- player")
	#print(tank_position, "- tank")
	#print(int(player_position.x), " % ", int(tank_position.x), " = ", (int(player_position.x) % int(tank_position.x)))
	
func shoot_shell():
	print("shoot")
	var shell = shell_path.instance()
	add_child(shell)

func get_tank_position():
	tank_position = get_global_position()
	
func get_player_position():
	player_position = get_node("../Player/Area2D/AnimatedSprite").get_global_position()
	
#func when_shoot():
	
	#if (tank_position.x > player_position.x):	
		#if (int(player_position.x) % int(tank_position.x)) < 300:
			#shoot()
	#else:
		#if (int(tank_position.x) % int(player_position.x)) < 300:
			#shoot()
	
func decide_facing_direction():
	
	if player_position.x > tank_position.x + 10:
		set_animation("default")
		set_flip_h(true)
	elif player_position.x < tank_position.x - 10: 
		set_animation("default")
		set_flip_h(false)
	else:
		set_animation("straight")
		
func shoot():
	if (has_fired == false and number_of_shells == 0 and on_screen == true):
			shoot_shell()
			$AudioCannonShot._set_playing(true)
			has_fired = true
			number_of_shells = 1	
			$fireTimer.start()
				
#reset shooting timer
func reset_shoot():
	number_of_shells = 0
	
#reset shooting timer
func _on_fireTimer_timeout() -> void:
	has_fired = false

func _on_VisibilityNotifier2D_screen_entered() -> void:
	$on_screen_delay_true.start()

func _on_VisibilityNotifier2D_screen_exited() -> void:
	on_screen = false
	
func _on_on_screen_delay_true_timeout() -> void:
	on_screen = true
