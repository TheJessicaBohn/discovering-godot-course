extends Control

var player_words = []

var current_story = {}	

onready var PlayerText = $VBoxContainer/HBoxContainer/PlayerText	
onready var DisplayText = $VBoxContainer/DisplayText
onready var Label = $VBoxContainer/HBoxContainer/Label

func _ready():
	set_current_story()
	DisplayText.text = "Welcome to Looney Lips! We're  going to tell a story and have a wonderful time!"
	check_player_words_length()
	PlayerText.grab_focus()
		


func set_current_story():
	randomize()
	var stories = get_from_jason("StoryBook.json")
	current_story = stories[randi() % stories.size()]
#	var stories = $StoryBook.get_child_count()
#	var selected_story = randi() % stories
#	current_story.prompts = $StoryBook.get_child(selected_story).prompts
#	current_story.story = $StoryBook.get_child(selected_story).story
#	current_story = template[randi() % template.size()]


func get_from_jason(filename):
	var file = File.new() 
	file.open(filename, File.READ)
	var text = file.get_as_text()
	var data =  parse_json(text)
	file.close()
	return data
	
	
func _on_PlayerText_text_entered(_new_text):
	add_to_player_words()
	
	
func _on_TextureButton_pressed():
	if is_story_done():
		get_tree().reload_current_scene()
	else:
		add_to_player_words()
	

func add_to_player_words():
	player_words.append(PlayerText.text)	
	DisplayText.text = ""
	PlayerText.clear()
	check_player_words_length()
	
	
func is_story_done():
	return player_words.size() == current_story.prompts.size()
		

func check_player_words_length():
	if is_story_done():
		end_game()
	else:
		prompt_player()
		

func tell_story():
	DisplayText.text = current_story.story % player_words


func prompt_player():	
	DisplayText.text += "May I have " + current_story.prompts[player_words.size()] + " please?"


func end_game():
	PlayerText.queue_free()
	_on_Label_gui_input()
	tell_story()


func _on_Label_gui_input():
	Label.text = "Again"
