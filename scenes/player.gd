#script: player
extends Area2D
class_name Player

signal spawn_laser(location)
signal spawn_double_laser(location)
signal player_died
signal player_has_take_dama
var player_has_died = false
var hp = 3
var canShoot = true
var MAX_SPEED = 400
var gamepad = true
onready var playerShootSound = $playerShoot
onready var muzzle = $Muzzle
export var shootDelay = 0.2
export var MOUSE_SPEED = 0.2

func _on_joy_connection_changed(device_id, connected):
	if connected:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		gamepad = true
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		gamepad = false

#Começo
func _ready():
	#Gamepad Connection
	Input.connect("joy_connection_changed", self, "_on_joy_connection_changed")

#Movimento e ações
func ready_to_shoot():
	canShoot = true

# Update process
func _process(_delta):
	
	if gamepad:
		var input_vector = Vector2(
			Input.get_joy_axis(0, JOY_ANALOG_LX),
			Input.get_joy_axis(0, JOY_ANALOG_LY)
		)
		
		if input_vector.length() > 0.2:
			position += input_vector * MAX_SPEED * _delta
		else:
			position += Vector2()
	else:
		position.y = lerp(position.y, get_global_mouse_position().y, MOUSE_SPEED)
		position.x = lerp(position.x, get_global_mouse_position().x, MOUSE_SPEED)	
			
	if Input.is_action_pressed("shoot"):
		if canShoot == true:
			shoot_laser()
			canShoot = false
			
	if Input.is_action_pressed("double_shoot"):
		if canShoot == true:
			shoot_double_laser()
			canShoot = false

#Receber Dano
func take_damage(damage):
	hp -= damage
	emit_signal("player_has_take_dama")
	if hp <=0:
		queue_free()
		player_has_died = true
		emit_signal("player_died")
	
func _on_player_area_entered(area):
	if area.is_in_group("enemies"):
		area.take_damage(1)
		
#Atirar 

func shoot_laser():
	emit_signal("spawn_laser", muzzle.global_position)
	playerShootSound.play()
	$ShootTimer.set_wait_time(shootDelay)
	$ShootTimer.start()
	play_attackAnimation()
	
func shoot_double_laser():
	emit_signal("spawn_double_laser", muzzle.global_position)
	playerShootSound.play()
	$ShootTimer.set_wait_time(shootDelay)
	$ShootTimer.start()
	play_attackAnimation()

#Animações
onready var waveAnim = $AnimationPlayer

func play_attackAnimation():
	waveAnim.play("Attack");
	
func _on_AnimationPlayer_animation_finished(Attack):
# Verifique se a animação concluída é a "Attack"
	if Attack == "Attack":
		# Inicie a animação "RESET"
		waveAnim.play("RESET")


