extends CanvasLayer

var player
var player_health
var health_nodes = []

func _physics_process(delta: float) -> void:
	check_current_health()
	set_health_bar()
	
func check_current_health():
	var player = get_tree().get_current_scene().get_node("Player")
	player_health = player.total_health
	#print(player_health)
	
func set_health_bar():
	health_nodes = [$HBoxContainer2/health1, $HBoxContainer2/health2, $HBoxContainer2/health3, $HBoxContainer2/health4]
	
	
	if player_health == 4:
		health_nodes[0].set_visible(true)
		health_nodes[1].set_visible(true)
		health_nodes[2].set_visible(true)
		health_nodes[3].set_visible(true)
	elif player_health == 3: 
		health_nodes[0].set_visible(true)
		health_nodes[1].set_visible(true)
		health_nodes[2].set_visible(true)
		health_nodes[3].set_visible(false)
	elif player_health == 2: 
		health_nodes[0].set_visible(true)
		health_nodes[1].set_visible(true)
		health_nodes[2].set_visible(false)
		health_nodes[3].set_visible(false)
	elif player_health == 1: 
		health_nodes[0].set_visible(true)
		health_nodes[1].set_visible(false)
		health_nodes[2].set_visible(false)
		health_nodes[3].set_visible(false)
	else: 
		health_nodes[0].set_visible(false)
		health_nodes[1].set_visible(false)
		health_nodes[2].set_visible(false)
		health_nodes[3].set_visible(false)
