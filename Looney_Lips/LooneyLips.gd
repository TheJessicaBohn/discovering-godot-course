extends Control

func _ready():
	var prompts = [ " André ", " beautiful", "world", "Jéssica", "love"]
	var story = "Once upon a time a gentleman, called %s. He was the most %s prince in the %s. One day he met a commoner  called %s and fell in %s with her"
	print(story % prompts)
	#prompts = [ " Kylo Ren ", " hideous", "world", "Rey", "hate"]
	#print(story % prompts)
	#person = " Someone Else "
	#print("Once upon a time a gentle, called" + person + "the most beautiful prince in the world")

	$DisplayText.text = "Qualquer coisa na tela"