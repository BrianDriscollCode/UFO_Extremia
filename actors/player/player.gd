extends KinematicBody2D


const SPEED = 150
const UP = Vector2(0, -1)

var ufo_motion = Vector2(0,0)
var current_position = Vector2(0,0)
var acceleration_speed = 0

var total_health = 4

func _ready() -> void:
	$Area2D/AnimatedSprite/GravityBeamParticle.set_emitting(false)
	$Area2D/AnimatedSprite/GravityBeamImage.set_visible(false)

func _physics_process(delta: float) -> void:
	current_ufo_position()
	move()
	move_and_slide(ufo_motion, UP)
	gravity_beam()
	
func move(): 
	if Input.is_action_pressed("right"):
		ufo_motion.x = SPEED #+ acceleration_speed
		acceleration_speed += 1
	elif Input.is_action_pressed("left"):
		ufo_motion.x = -SPEED #+ acceleration_speed
		#acceleration_speed -= 1
	else:
		ufo_motion.x = 0
		acceleration_speed = 0
		
	if Input.is_action_pressed("up") and current_position.y > -157:
		ufo_motion.y = -SPEED
	elif Input.is_action_pressed("down") and current_position.y < 92:
		ufo_motion.y = SPEED 
	else:
		ufo_motion.y = 0
		
func current_ufo_position(): 
	current_position = get_position()

func gravity_beam():
	if Input.is_action_just_pressed("gravity_beam"):
		$SoundGravityBeam._set_playing(true)
	
	if Input.is_action_pressed("gravity_beam"):
		$Area2D/AnimatedSprite/GravityBeamParticle.set_emitting(true)
		$Area2D/AnimatedSprite/GravityBeamImage.set_visible(true)
		$Area2D/AnimatedSprite/GravityBeamParticle.set_visible(true)
		$Area2D/GravityBeamCollision.set_disabled(false)
		$GravityBeamLight.set_enabled(true)
	else: 
		$Area2D/AnimatedSprite/GravityBeamParticle.set_emitting(false)
		$Area2D/AnimatedSprite/GravityBeamImage.set_visible(false)
		$Area2D/AnimatedSprite/GravityBeamParticle.set_visible(false)
		$Area2D/GravityBeamCollision.set_disabled(true)
		$SoundGravityBeam._set_playing(false)
		$GravityBeamLight.set_enabled(false)

func _on_Area2D_area_entered(area: Area2D) -> void:
	$SoundRetrieveHuman._set_playing(true)

#external calls

func get_player_position():
	return get_position()


func _on_playerArea_area_entered(area: Area2D) -> void:
	total_health -= 1
	$SoundShipHit._set_playing(true)
	
	if total_health == 0 or total_health < 0:
		get_tree().change_scene("res://levels/gameOver.tscn")
		
