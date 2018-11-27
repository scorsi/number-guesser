extends Node

onready var message = $Message
onready var right_button = $Right

var guess = 500
var min_guessed = 0
var max_guessed = 1000
var ended = false

enum guess_type {
	greater,
	lesser
}

func _ready():
	message.text = "Is " + str(guess) + " your number?"

func _process(delta):
	if Input.is_action_just_pressed("up"):
		_try_guess(guess_type.greater)
	elif Input.is_action_just_pressed("down"):
		_try_guess(guess_type.lesser)
	elif Input.is_action_just_pressed("space"):
		if ended == true:
			_restart_game()
		else:
			_end_game()

func _try_guess(type):
	if type == guess_type.greater:
		min_guessed = guess
	else:
		max_guessed = guess
	guess = (min_guessed + max_guessed) / 2
	
	message.text = "Is " + str(guess) + " your number?"

func _end_game():
	ended = true
	message.text = "Yes! Your number was " + str(guess) + "!"
	right_button.text = "Restart"

func _restart_game():
	get_tree().reload_current_scene()

func _on_Greater_pressed():
	_try_guess(guess_type.greater)

func _on_Lesser_pressed():
	_try_guess(guess_type.lesser)

func _on_Right_pressed():
	if ended == true:
		_restart_game()
	else:
		_end_game()
