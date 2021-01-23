extends Control

var player_words = []
#var template = [
#		{
#		"prompts" : [ " a name ", " a noun", "adverb", "adjective"],
#		"story"  : "Once upon a time someone called %s ate a %s flavoured sandwich which made him fell all %s inside. Is was a %s day"
#		},
#		{
#		"story"	: "There once was %s called %s who searched far and wide for the mythical %s noun of %s. ",
#		"prompts" : ["a noun", " a name ", " an adjective ", " a name again"]
#		},
#		{
#		"story"	: "Once upon a time a  %s called %s and  felt  very. It was a %s day %s for all good %s. ",
#		"prompts" : [" a name ", " a thing ", " a feeling ", " a feeling again ", " some thing"]
#		},
#		{
#		"story"	: "There once was %s called %s that lived as %s as  %s. ",
#		"prompts" : [" a thing ", " a name ", " a description word (an adjective) ", " a thing again"]
#		},
#		{
#		"story"	: "There once was %s called %s who searched far and wide for the mythical %s noun of %s. ",
#		"prompts" : [" a noun ", " a name ", " an adjective ", " a name again"]
#		},
#		{
#		"story"	: "A poem. \n\nI wish I was a %s, %s as can be, \n Then you could call me %s,\n And I would  %s. %s %s ",
#		"prompts" : [" a noun (thing) ", " a name ", " an adjective (a description word) ", " a person's name ", " a place ", " a"]
#		},
#		{
#		"story"	: "Dear %s.\n\n I hope this letter finds you well, I have spent the past three weeks in %s researching the history of %s for my new book. I miss you %s, and whenever I see a %s and I think of you ",
#		"prompts" : ["a person's name", " the name of a place  ", " the plural of a noun (there's going to be more)", " an adverb (a word ending in -ly)", " a noun "]
#		},
#		{
#		"story"	: "Once upon a time, a %s hero called %s was sent to %s, to deafeat a %s %s. He did so, retu %s %s. ",
#		"prompts" : [" an adjective ", " a person ", " a place ", " an adjective again", " a noun ", " another place ", " an adjective "]
#		},
#		{
#		"story"	: "The utimate pizza recipe.\n\n Mix one package of %s with three spoonsfuls of flour. %s %s %s %s. ",
#		"prompts" : [" a noun ", " an adjective(descriptive) ", " another noun ", " yet another noun", " a noun ", " yet another noun ", " an adjective "]
#		},
#		]
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
	var stories = $StoryBook.get_child_count()
	var selected_story = randi() % stories
	current_story.prompts = $StoryBook.get_child(selected_story).prompts
	current_story.story = $StoryBook.get_child(selected_story).story
#	current_story = template[randi() % template.size()]

	
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
