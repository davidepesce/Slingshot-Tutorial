extends Line2D

onready var player = $"../Player"
onready var camera = $"../Player/Camera2D"
var on_slingshot = true
var impulse_direction = Vector2.ZERO


func _process(delta):
	if on_slingshot:
		var player_relative_position = player.position - position
		points[1] = player_relative_position
		if(impulse_direction.length() > 0):
			if player_relative_position.dot(impulse_direction) <= 0:
				player.apply_central_impulse(impulse_direction * 30 * player_relative_position.length() * delta)
				player.apply_torque_impulse(25 * delta)
			else:
				on_slingshot = false
				points[1] = Vector2.ZERO
				camera.drag_margin_bottom = 0.2
				camera.drag_margin_top = 0.2
				camera.drag_margin_left = 0.2
				camera.drag_margin_right = 0.2


func _on_Player_released():
	player.mode = RigidBody2D.MODE_RIGID
	impulse_direction = (position - player.position).normalized()
