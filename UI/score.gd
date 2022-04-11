extends CanvasLayer

var score = 0
var score_text = "0"

func _process(delta: float) -> void:
	score_text = str(score)
	$Control/HBoxContainer/Label.set_text(score_text)
	
	
func increase_score():
	score += 1
