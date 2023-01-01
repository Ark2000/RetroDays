extends CharacterBody2D

@export var max_speed := 40.0
@export var accel = 80.0

@onready var path := $Node/Path
@onready var sprite := $AnimatedSprite2D
@onready var hurtbox := $HurtBox

var dests := []
var dest_i := 0

func _ready():
	path.hide()
	for i in range(path.get_point_count()):
		dests.append(path.get_point_position(i) + path.position)
	hurtbox.body_entered.connect(
		func(player:CharacterBody2D):
			player.velocity.y = -player.JUMP_FORCE * 0.8
			var effect = G.clound_poof_effect.instantiate()
			effect.position = position
			get_tree().root.add_child(effect)
			queue_free()
	)

func _physics_process(delta):
	var dest:Vector2 = dests[dest_i]
	var target_velocity = (dest - position).normalized() * max_speed
	if dest.distance_to(position) < 20.0:
		target_velocity = (dest - position) * 3.0
		target_velocity.limit_length(max_speed)

	velocity = velocity.move_toward(target_velocity, accel * delta)

	if  (dest - position).length_squared() < 4.0:
		dest_i = (dest_i + 1) % len(dests)

	move_and_slide()
	
	sprite.flip_h = velocity.x > 0

	$Line2D.set_point_position(1, velocity)
