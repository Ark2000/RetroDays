#Reference: GMTK Platformer Toolkit (https://gmtk.itch.io/platformer-toolkit)

extends CharacterBody2D

@export_group("Movement Stats")
# Maximum movement speed
@export_range(0.0, 20.0) var max_speed := 10.0
# How fast to reach max speed
@export_range(0.0, 100.0) var max_acceleration := 52.0
# How fast to stop after letting go
@export_range(0.0, 100.0) var max_deceleration = 52.0
# How fast to stop when changing direction
@export_range(0.0, 100.0) var max_turn_speed := 80.0
# How fast to reach max speed when in mid-air
@export_range(0.0, 100.0) var max_air_acceleration:float
# How fast to stop in mid-air when no direction is used
@export_range(0.0, 100.0) var max_air_deceleration:float
# How fast to stop when changing direction when in mid-air
@export_range(0.0, 100.0) var max_air_turn_speed := 80.0
# Friction to apply against movement on stick
@export var friction:float

@export_group("Movement Options")
# When false, the charcter will skip acceleration and deceleration and instantly move and stop
@export var use_acceleration := true

@export_group("Jumping Stats")
# Maximum jump height
@export_range(2.0, 5.5) jump_height := 7.3
# How long it takes to reach that height before coming back down
@export_range(0.2, 1.25) time_to_jump_apex:float
# Gravity multiplier to apply when going up
@export_range(0.0, 5.0) upward_movement_multiplier := 6.17
# Gravity multiplier to apply when coming down
@export_range(1.0, 10.0) downward_movement_multiplier := 6.17
# How many times can you jump in the air?
@export_range(0, 1) var max_air_jumps := 0

@expor_group("Jumping Options")


#===Calculations===#
var direction_x:float
var desired_velocity:Vector2
var real_velocity:Vector2
var max_speed_change:float 
var acceleration:float 
var deceleration:float 
var turn_speed:float

#===Current State===#
var on_ground:bool 
var pressing_key:bool 