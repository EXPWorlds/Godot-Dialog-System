tool
extends WindowDialog

onready var _Text_Editor = self.get_node("VBoxContainer/TextEdit")

var _Target_Node

#Public Methods

func set_target_node(node):
	self._Target_Node = node
	self._Text_Editor.text = node.get_text()

#Callback Methods

func _on_OK_BTN_pressed():
	self.visible = false


func _on_TextEdit_text_changed():
	self._Target_Node.set_text(self._Text_Editor.text)
