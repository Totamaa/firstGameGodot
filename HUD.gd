extends CanvasLayer

signal start_game
signal sound_on
signal sound_off

func _ready():
	$ScoreLabel.show()
	$Message.show()
	$StartButton.show()
	$Settings.show()
	$exitSettings.hide()
	$soundsButton.hide()
	$sounds.hide()

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func show_game_over():
	show_message("Game Over")
	# Wait until the MessageTimer has counted down.
	yield($MessageTimer, "timeout")

	$Message.text = "Dodge the\nCreeps!"
	$Message.show()
	# Make a one-shot timer and wait for it to finish.
	yield(get_tree().create_timer(1), "timeout")
	$StartButton.show()
	$Settings.show()

func update_score(score):
	$ScoreLabel.text = str(score)

func _on_StartButton_pressed():
	$StartButton.hide()
	$Settings.hide()
	emit_signal("start_game")

func _on_MessageTimer_timeout():
	$Message.hide()


func _on_Settings_pressed():
	$ScoreLabel.hide()
	$Message.hide()
	$StartButton.hide()
	$Settings.hide()
	$exitSettings.show()
	$soundsButton.show()
	$sounds.show()
	

func _on_exitSettings_pressed():
	$ScoreLabel.show()
	$Message.show()
	$StartButton.show()
	$Settings.show()
	$exitSettings.hide()
	$soundsButton.hide()
	$sounds.hide()
	

func _on_soundsButton_pressed():
	if $soundsButton.toggle_mode == true:
		emit_signal("sound_on")
	else:
		emit_signal("sound_off")
