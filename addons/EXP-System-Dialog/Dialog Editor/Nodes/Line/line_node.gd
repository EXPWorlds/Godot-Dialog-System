tool
extends GraphNode

signal changed_offset(nid, vec2)
signal changed_size(this)
signal changed_slots(this)
signal erased(this)
signal pressed_editor(this)
signal pressed_load(this)
signal pressed_save(this)
signal text_changed(nid, new_text)

onready var _Link_SpinBox = self.get_node("VBoxContainer/HBoxContainer/Link_SpinBox")
onready var _Text_Editor = self.get_node("VBoxContainer/HBoxContainer2/TextEdit")

var _nid : int = 0
var _slot_amount : int = 1

#Virtual Methods

func _ready():
	self._update_slots()

#Callback Methods

func _on_Editor_BTN_pressed():
	self.emit_signal("pressed_editor", self)


func _on_Line_close_request():
	self.emit_signal("erased", self)


func _on_Line_offset_changed():
	self.emit_signal("changed_offset", self._nid, self.offset)


func _on_Line_resize_request(new_minsize):
	self.rect_size = new_minsize
	self.emit_signal("changed_size", self)


func _on_Link_SpinBox_value_changed(value):
	self._slot_amount = int(self._Link_SpinBox.value)
	self._update_slots()
	self.emit_signal("changed_slots", self)


func _on_Load_BTN_pressed():
	self.emit_signal("pressed_load", self)


func _on_Save_BTN_pressed():
	self.emit_signal("pressed_save", self)


func _on_TextEdit_text_changed():
	self.emit_signal("text_changed", self._nid, self._Text_Editor.text)

#Public Methods

func get_nid() -> int:
	return self._nid


func get_slot_amount() -> int:
	return self._slot_amount


func get_text() -> String:
	return self._Text_Editor.text


func set_nid(new_nid):
	self._nid = new_nid
	var new_name = "NID " + str(new_nid)
	self.title = new_name
	self.name = new_name


func set_slot_amount(new_amount : int):
	self._slot_amount = new_amount


func set_text(new_text : String):
	self._Text_Editor.text = new_text
	self.emit_signal("text_changed", self._nid, new_text)

#Private Methods

func _clear_link_labels():
	var children = self.get_children()
	for child in children:
		if child is Label:
			child.free()


func _update_slots():
	self.clear_all_slots()
	self._clear_link_labels()
	self.set_slot(0, true, 0, Color(1.0, 1.0, 1.0, 1.0), true, 0, Color(1.0, 1.0, 1.0, 1.0), null, null)
	var base_link_label = Label.new()
	base_link_label.text = "0"
	base_link_label.align = Label.ALIGN_RIGHT
	self.add_child(base_link_label)
	self.move_child(base_link_label, 0)
	var last_output_link_label = base_link_label
	for slot in range(1, self._slot_amount):
		self.set_slot(slot, false, 0, Color(1.0, 1.0, 1.0, 1.0), true, 0, Color(1.0, 1.0, 1.0, 1.0), null, null)
		var output_link_label = Label.new()
		output_link_label.text = str(slot)
		output_link_label.align = Label.ALIGN_RIGHT
		self.add_child_below_node(last_output_link_label, output_link_label)
		last_output_link_label = output_link_label
