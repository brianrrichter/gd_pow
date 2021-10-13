extends Area2D

var move_speed = 0.0
var base_speed = 120.0
var direction = Vector2.UP
var seconds_since_creation = 0.0
var max_charge_time = 5.0
onready var status = e_status.CHARGE

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

enum e_status {
	CHARGE,
	RUNNING,
	DYING
}


# Called when the node enters the scene tree for the first time.
func _ready():
	$LifeSpanTimer.connect("timeout", self, "time_expired")
	$AnimationPlayerInit.play("Appear")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if status == e_status.CHARGE:
		if int(seconds_since_creation + delta) > int(seconds_since_creation): #entra 1 vez a cada segundo
#			print(int(seconds_since_creation + delta))
#			print(int(seconds_since_creation))
			var particle_d = $Particles/Particles2D.duplicate()
			$Particles.add_child_below_node($Particles/Particles2D, particle_d)
#			if int(seconds_since_creation) >= 3:
#				$AnimationPlayer.play("blink3")
#			elif int(seconds_since_creation) >= 2:
#				$AnimationPlayer.play("blink2")
#			elif int(seconds_since_creation) >= 1:
#				$AnimationPlayer.play("blink1")
			$AnimationPlayer.play("blink2", -1, int(seconds_since_creation + delta))
	
	seconds_since_creation += delta
	
#	$Particles2D.amount = 5 + seconds_since_creation
	
	
	if status == e_status.CHARGE and seconds_since_creation >= max_charge_time:
		die()
	
	if status == e_status.RUNNING:
		position += direction.normalized() * move_speed * delta
	


func time_expired():
	if status != e_status.DYING:
		die()

func die():
	status = e_status.DYING
	$icon.hide()
	$CollisionShape2D.set_disabled(true)
	for p in $Particles.get_children():
		print("emiting....", p)
		p.set_emitting(false)
	yield(get_tree().create_timer(2.0), "timeout")
	queue_free()

func go(var dir):
	status = e_status.RUNNING
#	$icon.rotation_degrees = direction.angle()
#	$icon.look_at(direction)
	
	self.direction = dir
	move_speed = base_speed * seconds_since_creation
	$LifeSpanTimer.start();
	


