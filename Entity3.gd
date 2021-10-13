extends "res://EntityBase.gd"

func _init():
	points = +30

func on_area_entered(object):
	print("aaaaaaa")
	$CollisionShape2D.set_disabled(true)
	$AnimationPlayer.play("explode")
	status = e_status.DYING
	
#	yield(get_tree().create_timer(1.0), "timeout")
	

#é chamado no fim da animação
func die2():
	die();
