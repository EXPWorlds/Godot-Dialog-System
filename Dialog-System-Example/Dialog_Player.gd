extends Node


func _ready():
	var Story_Reader_Class = load("res://addons/EXP-System-Dialog/Reference_StoryReader/EXP_StoryReader.gd")
	var Story_Reader = Story_Reader_Class.new()
	
	var story = load("res://Dialog-System-Example/Example_Story_Baked.tres")
	Story_Reader.read(story)
	
	var did : int = 3
	var nid : int = 1
	var text : String = Story_Reader.get_text(did, nid)
	
	print(text)
