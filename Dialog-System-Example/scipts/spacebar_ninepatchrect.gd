extends NinePatchRect

export(float) var _blink_speed = 0.25
export(float) var _blink_amplitude = 0.1
var _direction = -1.0

# Virtual Methods

func _process(delta):
	self._blink()

# Private Methods

func _blink():
	var change = self._blink_speed * self._direction * self.get_process_delta_time()
	var change_vector = Vector2(change, change)
	self.rect_scale += change_vector
	
	if self.rect_scale.x < (1.0 - self._blink_amplitude):
		var amplitude = 1.0 - self._blink_amplitude
		self.rect_scale = Vector2(amplitude, amplitude)
		self._direction *= -1.0
	
	if self.rect_scale.x > 1.0:
		self.rect_scale = Vector2(1.0, 1.0)
		self._direction *= -1.0
