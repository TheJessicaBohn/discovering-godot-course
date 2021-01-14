extends Control

var player_words = []
var story = "Once upon a time a gentleman, called %s. He was the most %s prince in the %s. One day he met a commoner  called %s and fell in %s with her"
var prompts = [ " a name ", " a noun", "adverb", "adjective"]

onready var PlayerText = $VBoxContainer/HBoxContainer/PlayerText	
onready var DisplayText = $VBoxContainer/DisplayText

func _ready():
	check_player_words_length()
		
	
func _on_PlayerText_text_entered(new_text):
#	update_DisplayText(new_text)
#	story = ""
	add_to_player_words()	
	
	
func _on_TextureButton_pressed():
#	var words = PlayerText.text
#	update_DisplayText(words)
	add_to_player_words()


#func update_DisplayText(words):
#	$VBoxContainer/DisplayText.text = words
#	$VBoxContainer/HBoxContainer/PlayerText.clear()


func add_to_player_words():
	player_words.append(PlayerText.text)	
	
	
func is_story_done():
	return player_words.size() == prompts.size()
		

func check_player_words_length():]
	if is_story_done():
		tell_story()
	else:
		prompts_player()

func tell_story():
	DisplayText.text = story % player_words

func prompts_player():	
	DisplayText.text = "May I have"	+ prompts[player_words.size()] + " please?"
							
