extends PanelContainer

# Get a reference to the HSlider node from the scene tree.
@onready var h_slider: HSlider = $VBoxContainer/HBoxContainer/HSlider

# We'll store the index for the "Master" audio bus. It's almost always 0.
var _master_bus_idx: int


func _ready() -> void:
	# Find the bus index by its name. This is safer than assuming it's 0.
	_master_bus_idx = AudioServer.get_bus_index("Master")
	
	# --- Configure the Slider's Range ---
	# We want the slider to represent a linear volume scale from 0 (mute) to 2.0 (double).
	# A value of 1.0 will represent the default, un-boosted volume (0 dB).
	h_slider.min_value = 0.0
	h_slider.max_value = 2.0
	h_slider.step = 0.01 # Allows for fine-grained control.

	# --- Set the Slider's Starting Position ---
	# Get the master bus's current volume in decibels (dB).
	var current_volume_db: float = AudioServer.get_bus_volume_db(_master_bus_idx)
	
	# Sliders work best with linear values, so we convert the bus's dB value
	# to a linear scale (e.g., -6 dB becomes ~0.5 linear).
	var current_volume_linear: float = db_to_linear(current_volume_db)
	
	# Set the slider's value to match the current volume. This ensures the slider
	# is in the correct position when the game starts.
	# We use set_value_no_signal to prevent it from triggering the _on_value_changed
	# function unnecessarily right at the start.
	h_slider.set_value_no_signal(current_volume_linear)


# This function is connected to the slider's "value_changed" signal.
# It runs every time the slider's value changes (including during a drag).
func _on_h_slider_value_changed(new_linear_value: float) -> void:
	# The slider gives us a linear value (0.0 to 2.0).
	# The AudioServer needs this converted back to the decibel (dB) scale.
	var new_volume_db: float = linear_to_db(new_linear_value)
	
	# Set the volume of the master bus.
	AudioServer.set_bus_volume_db(_master_bus_idx, new_volume_db)

func close():
	visible = false
