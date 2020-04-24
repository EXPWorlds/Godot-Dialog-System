tool
extends Control

signal changed_human_readable_text(did, text)
signal checked(this)
signal edit_pressed(did)
signal rename_pressed(this)
signal unchecked(this)

onready var _DID_LBL = self.get_node("ColorRect/HBoxContainer/DID_LBL")
onready var _Human_Readable_LineEdit = self.get_node("ColorRect/HBoxContainer/Human_Readable_LineEdit")
onready var _Group_List = self.get_node("ColorRect/HBoxContainer/Group_BTN")
onready var _Name_BTN = self.get_node("ColorRect/HBoxContainer/Name_BTN")
onready var _Select_CheckBox = self.get_node("ColorRect/HBoxContainer/CheckBox")

var _did : int = -1
var _Story_Editor

#Virtual Methods

func _ready():
	self.update_human_readable_description("Human Readable Description")

#Callback Methods

func _on_CheckBox_toggled(button_pressed):
	if button_pressed:
		self.emit_signal("checked", self)
	else:
		self.emit_signal("unchecked", self)


func _on_Edit_BTN_pressed():
	self.emit_signal("edit_pressed", self._did)


func _on_Group_BTN_pressed():
	var groups = self._Story_Editor.dialog_get_groups(self._did)
	self._Group_List.clear()
	self._Group_List.text = "TAGS"
	for group in groups:
		self._Group_List.get_popup().add_item(group)
	for idx in range(self._Group_List.get_item_count()):
		self._Group_List.set_item_disabled(idx, true)


func _on_Human_Readable_LineEdit_focus_exited():
	self._Human_Readable_LineEdit.deselect()


func _on_Human_Readable_LineEdit_text_changed(new_text):
	self.emit_signal("changed_human_readable_text", self._did, new_text)


func _on_Name_BTN_pressed():
	emit_signal("rename_pressed", self)

#Public Methods

func check():
	self._Select_CheckBox.pressed = true


func get_did():
	return self._did


func get_record_name():
	return self._Name_BTN.text


func set_did(new_did : int):
	self._did = new_did
	self._DID_LBL.text = "DID: " + str(new_did)


func set_record_name(rename : String):
	self._Name_BTN.text = rename


func set_story_editor(editor):
	self._Story_Editor = editor


func uncheck():
	self._Select_CheckBox.pressed = false


func update_human_readable_description(new_text):
	self._Human_Readable_LineEdit.text = new_text
	self.emit_signal("changed_human_readable_text", self._did, new_text)
