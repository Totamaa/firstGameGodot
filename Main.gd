extends Node

export (PackedScene) var Mob
var score


# Called when the node enters the scene tree for the first time.
func _ready():
	$Music.volume_db = -15
	$DeathSound.volume_db = -15
	randomize()




func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	get_tree().call_group("mobs", "queue_free")
	$Music.stop()
	$DeathSound.play()


func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$Music.play()

# Faire spawner les monstres
func _on_MobTimer_timeout():
	# On choisit une location random de notre cadre
	$MobPath/MobSpawnLocation.offset = randi()
	# On crée un mob et on l'ajoute a la scène
	var mob = Mob.instance()
	add_child(mob)
	# On oriente le mob vers le centre
	var direction = $MobPath/MobSpawnLocation.rotation + PI / 2
	# on met le monstre dans une position random
	mob.position = $MobPath/MobSpawnLocation.position
	# on ajoute un angle (en radiant) au mosntre 
	direction += rand_range(-PI / 4, PI / 4)
	mob.rotation = direction
	# On donne la velocité au monstre (vitesse et direction)
	mob.linear_velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0)
	mob.linear_velocity = mob.linear_velocity.rotated(direction)


func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)


func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()



func _on_HUD_sound_on():
	$Music.volume_db = -15
	$DeathSound.volume_db = -15



func _on_HUD_sound_off():
	$Music.volume_db = -80
	$DeathSound.volume_db = -80
