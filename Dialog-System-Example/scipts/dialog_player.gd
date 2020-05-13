extends Node

signal pressed_spacebar

onready var _Body_LBL = self.find_node("Body_Label")
onready var _Dialog_Box = self.find_node("Dialog_Box")
onready var _Name_LBL = self.find_node("Name_Label")
onready var _SpaceBar_Icon = self.find_node("SpaceBar_NinePatchRect")

var _did = 0
var _nid = 0
var _Story_Reader
var _playing_dialog = false

# Virtual Methods

func _ready():
	var Story_Reader_Class = load("res://addons/EXP-System-Dialog/Reference_StoryReader/EXP_StoryReader.gd")
	self._Story_Reader = Story_Reader_Class.new()
	
	var story = load("res://Dialog-System-Example/stories/Example_Story_Baked.tres")
	self._Story_Reader.read(story)
	
	self._Dialog_Box.visible = false
	self._SpaceBar_Icon.visible = false
	
	self.play_dialog("Plains/Battle/Slime")


func _input(event):
	if event is InputEventKey:
		if event.pressed == true and event.scancode == KEY_SPACE:
			self.emit_signal("pressed_spacebar")

# Callback Methods

func _on_Body_Label_text_displayed():
	self._SpaceBar_Icon.visible = true


func _on_Dialog_Player_pressed_spacebar():
	if self._SpaceBar_Icon.visible == true:
		self._SpaceBar_Icon.visible = false
		self._get_next_node()
		if self._playing_dialog:
			self._play_node()
		else:
			self._Dialog_Box.visible = false

# Public Methods

func play_dialog(record_name : String):
	self._playing_dialog = true
	self._did = self._Story_Reader.get_did_via_record_name(record_name)
	self._nid = self._Story_Reader.get_nid_via_exact_text(self._did, "<start>")
	self._get_next_node()
	self._play_node()
	self._Dialog_Box.visible = true

# Private Methods

func _get_next_node():
	self._nid = self._Story_Reader.get_nid_from_slot(self._did, self._nid, 0)
	var final_nid = self._Story_Reader.get_nid_via_exact_text(self._did, "<end>")
	
	if self._nid == final_nid:
		self._playing_dialog = false


func _get_tagged_text(tag : String, text : String):
	var start_tag = "<" + tag + ">"
	var end_tag = "</" + tag + ">"
	var start_index = text.find(start_tag) + start_tag.length()
	var end_index = text.find(end_tag)
	var substr_length = end_index - start_index
	return text.substr(start_index, substr_length)


func _play_node():
	var raw_text = self._Story_Reader.get_text(self._did, self._nid)
	var speaker_name = self._get_tagged_text("speaker", raw_text)
	var dialog = self._get_tagged_text("dialog", raw_text)
		
	self._Name_LBL.text = speaker_name
	self._Body_LBL.display(dialog)
