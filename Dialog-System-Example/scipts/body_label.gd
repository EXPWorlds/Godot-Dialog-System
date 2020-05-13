extends Label

signal text_displayed

export(float) var _speed = 1.0

# Virtual Methods

func _ready():
	self.set_process(false)


func _process(delta):
	self._do_text()

# Public Methods

func display(new_text : String):
	self.percent_visible = 0.0
	self.text = new_text
	self.set_process(true)

# Private Methods

func _do_text():
	var new_percent = self.percent_visible + (self._speed * self.get_process_delta_time())
	
	if new_percent <= 1.0:
		self.percent_visible = new_percent
	else:
		self.percent_visible = 1.0
		self.set_process(false)
		self.emit_signal("text_displayed")
