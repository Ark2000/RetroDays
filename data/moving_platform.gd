extends AnimatableBody2D

@export var max_speed := 40.0
@export var accel = 80.0

@export var path:Line2D
@export var reverse:bool = false

var dests := []
var dest_i := 0

var vel:Vector2

func _ready():
	if path:
		for i in range(path.get_point_count()):
			dests.append(path.get_point_position(i) + path.global_position)
		path.queue_free()
		if reverse:
			dests.reverse()
		#be careful of this.
		set_deferred("global_position", dests[0])
	
func _physics_process(delta):
	if dests.size() > 0:
		var dest:Vector2 = dests[dest_i]
		var target_velocity = (dest - position).normalized() * max_speed
		if dest.distance_to(position) < 20.0:
			target_velocity = (dest - position) * 3.0
			target_velocity.limit_length(max_speed)

		vel = vel.move_toward(target_velocity, accel * delta)

		if  (dest - position).length_squared() < 4.0:
			dest_i = (dest_i + 1) % len(dests)
			
	position += vel * delta
