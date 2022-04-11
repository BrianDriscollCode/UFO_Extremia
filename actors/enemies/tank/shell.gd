extends KinematicBody2D
export (PackedScene) var Bullet


const SPEED = 100
const UP = Vector2(0, -1)

var shell_direction = Vector2(0,0)
var player_position_pulled = false
var shell_speed = Vector2(0,0)
var player_body = null

var is_exploded = false


func _physics_process(delta: float) -> void:
	get_player_direction()
	set_shell_position(delta)
	
	if is_exploded == false:
		position += SPEED*delta*shell_direction

func get_player_direction():
	if player_position_pulled == false:
		player_body = get_tree().get_current_scene().get_node("Player/Area2D/AnimatedSprite")
		#set direction of shell
		shell_direction = (player_body.get_global_position() - get_global_position()).normalized()
		player_position_pulled = true #stop from resetting position
	
func set_shell_position(delta):
	position += SPEED*delta*shell_direction

func _on_VisibilityNotifier2D_screen_exited() -> void:
	get_parent().reset_shoot()
	queue_free()

func _on_Area2D_area_entered(area: Area2D) -> void:
	is_exploded = true
	$Area2D.set_monitorable(false)
	$Area2D.set_monitoring(false)
	$Area2D/CollisionShape2D.set_disabled(true)
	$AnimatedSprite.set_animation("explosion")
