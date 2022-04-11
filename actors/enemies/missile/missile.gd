extends AnimatedSprite

const SPEED = 60


var missile_direction = Vector2(0,0)
var player_body 
var angle 

func _ready() -> void:
	set_flip_h(true)

func _physics_process(delta: float) -> void:
	get_player_position()
	follow_player()
	position += SPEED*delta*missile_direction

	

func follow_player():
	missile_direction = (player_body.get_global_position() - get_global_position()).normalized()
	angle = missile_direction.angle()
	var r = global_rotation
	global_rotation = lerp_angle(r, angle, 0.02)
	

func get_player_position():
	player_body = get_tree().get_current_scene().get_node("Player/Area2D/AnimatedSprite")


func _on_Area2D_area_entered(area: Area2D) -> void:
	set_scale(Vector2(1.5,1.5))
	set_animation("explode")
	$Area2D/CollisionShape2D.set_disabled(true)
	$free_up_timer.start()

func _on_free_up_timer_timeout() -> void:
	queue_free()

func _on_explode_timer_timeout() -> void:
	set_scale(Vector2(1.5,1.5))
	set_animation("explode")
	$Area2D/CollisionShape2D.set_disabled(true)
	$explode_sound._set_playing(true)
	$free_up_timer.start()
	
