tool
extends WindowDialog

signal rename_BTN_pressed(text)

onready var _Name_LineEdit = self.get_node("MarginContainer/VBoxContainer/Name_LineEdit")

var _Target_Record = null

#Public Methods

func get_target_record():
	return self._Target_Record


func set_target_record(record):
	self._Target_Record = record
	self._Name_LineEdit.text = record.get_record_name()

#Callback Methods

func _on_Cancel_BTN_pressed():
	self.visible = false


func _on_Rename_BTN_pressed():
	self.visible = false
	self.emit_signal("rename_BTN_pressed", self._Name_LineEdit.text)


func _on_Name_LineEdit_text_entered(new_text):
	self._on_Rename_BTN_pressed()
