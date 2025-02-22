# worldScript.gd, todos os estágios extendem esse script, inclui ações do player e input (deveria ser no script do player mas whatever)
extends Node2D

export (int) var stageIndex 
var Laser = preload("res://projectiles/PlayerLaser.tscn")
var LaserDiagonalDW = preload("res://projectiles/DiagonalLaserDown.tscn")
var LaserDiagonalUP = preload("res://projectiles/DiagonalLaserUp.tscn") 
export var score = 50
export var lifes = 3
export (PackedScene) var nextScene 
	
func _ready():
	$score.text = "Inimigos Restantes: "+str(score)
	$lifes.text = "Vidas: "+str(lifes)
	
func _process(delta):
	if score <=0 and not $EnemySpawner.is_boss_spawned:
		$EnemySpawner.is_boss_spawned = true
		var boss = $EnemySpawner._spawn_boss(stageIndex)
		boss.connect("boss_died", self, "end_game")
			
func end_game():
	#botar funções de audio, animação, efeitos e particulas aqui!
	get_tree().change_scene_to(nextScene)

# Isso de fato "ATIRA" o laser (instancia o node da posição do muzzle)
func _on_player_spawn_laser(location):
	var l = Laser.instance()
	l.global_position = location
	add_child(l)
	
func _on_player_spawn_double_laser(location):
	var l1 = LaserDiagonalUP.instance()
	var l2 = LaserDiagonalDW.instance()
	l1.global_position = location
	l2.global_position = location
	add_child(l1)
	add_child(l2)

func score():
	score -=1
	$score.text = "Inimigos Restantes: "+str(score)
	

func _on_player_has_take_damage():
	lifes -=1
	$lifes.text = "Vidas: "+str(lifes)
