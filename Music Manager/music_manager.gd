extends Node

# All layers of songs added should have a length equal to the length of the backing track
# i.e. the bg track is 1 min, then the layer is also 1 min with empty audio where it shouldnt be playing
# This is because the time of the audio stream will be equal to the current time of the main audio stream


#                             Quick Tutorial on using this:
#call load song with the beats per minute, beats per measure, and loaded audio stream
#then call start song with no parameters
#if you need to add anything use the add next beat or add next measure to do so
#with these two functions, enter a name in the second parameter to allow them to not kill themselves after playing
#then you can use remove next beat or remove next measure with the aforementioned name to kill them on queue
#
#The swap next m/b functions will kill all audio then play their audio
#if you give them full parameters they will use that information to create a new backing track
#if you only give a sound, they will play it as a oneshot

var backing_track : AudioStreamPlayer

var beat_time : float
var measure_time : float

var beat_queue : Array = []
var r_beat_queue : Array = []
var beat_dictionary : Dictionary = {}

var measure_queue : Array = []
var r_measure_queue : Array = []
var measure_dictionary : Dictionary = {}

@export var beat_timer : Timer
@export var measure_timer : Timer

@export var metronome : bool = false

func load_song(bpm : float, beats_per_measure : float, song : AudioStream):
	if not beat_timer or not measure_timer : print_debug("Set the timer export bozo"); return
	for child in $"Audio Players".get_children():
		child.queue_free()
	
	beat_time = 1/(bpm/60)
	measure_time = beat_time*beats_per_measure
	beat_timer.wait_time = beat_time
	measure_timer.wait_time = measure_time
	
	backing_track = create_audio_player(song)

##If called with parameters, you can omit the load song function
##ideally you call load song with parameters then start song with no parameters smile
func start_song(bpm : float = 0, beats_per_measure : float = 0, song : AudioStream = null):
	if not bpm or not beats_per_measure or not song:
		beat_timer.start()
		measure_timer.start()
		backing_track.play()
		if not metronome : return
		create_oneshot_audio_player(load("res://Music Manager/measure_debug.wav")).play()
	else:
		load_song(bpm, beats_per_measure, song)
		start_song()

func swap_next_beat(song : AudioStream, bpm : float = 0, beats_per_measure : float = 0):
	await $Beat.timeout
	for child in $"Audio Players".get_children():
			child.queue_free()
	if not bpm or not beats_per_measure:
		create_oneshot_audio_player(song).play()
	else:
		load_song(bpm, beats_per_measure, song)
		start_song()

func swap_next_measure(song : AudioStream, bpm : float = 0, beats_per_measure : float = 0):
	await $Measure.timeout
	for child in $"Audio Players".get_children():
			child.queue_free()
	if not bpm or not beats_per_measure:
		create_oneshot_audio_player(song).play()
	else:
		load_song(bpm, beats_per_measure, song)
		start_song()

##adds a sound that will play on the next beat of the song
##if the sound is not given a name it will be treated as a oneshot and only played once
##the purpose of the name is to allow for sounds to loop and eventually be removed through their name
func add_next_beat(stream : AudioStream, name : String = ""):
	if name == "":
		var player = create_oneshot_audio_player(stream)
		beat_queue.append(player)
	else:
		if beat_dictionary.has(name) : print("Sound key already associated, not creating a new audio player."); return
		var player = create_audio_player(stream)
		beat_dictionary[name] = player
		beat_queue.append(player)

func add_next_measure(stream :AudioStream, name : String = ""):
	if name == "":
		var player = create_oneshot_audio_player(stream)
		measure_queue.append(player)
	else:
		if measure_dictionary.has(name) : print("Sound key already associated, not creating a new audio player."); return
		var player = create_audio_player(stream)
		measure_dictionary[name] = player
		measure_queue.append(player)

func remove_next_beat(name : String):
	if not beat_dictionary.has(name): return
	r_beat_queue.append(beat_dictionary[name])

func remove_next_measure(name : String):
	if not measure_dictionary.has(name): return
	r_measure_queue.append(beat_dictionary[name])

func _on_beat_timeout():
	if not beat_queue.is_empty():
		for player : AudioStreamPlayer in beat_queue:
			player.play()
			if player.stream.get_length() == backing_track.stream.get_length():
				player.seek(backing_track.get_playback_position())
		beat_queue.clear()
	
	if not r_beat_queue.is_empty():
		for name : String in r_beat_queue:
			beat_dictionary[name].queue_free()
		r_beat_queue.clear()
	
	if not metronome:return
	if measure_timer.time_left >= beat_time:
		create_oneshot_audio_player(load("res://Music Manager/beat_debug.wav")).play()

func _on_measure_timeout():
	if not measure_queue.is_empty():
		for player : AudioStreamPlayer in measure_queue:
			player.play()
			if player.stream.get_length() == backing_track.stream.get_length():
				player.seek(backing_track.get_playback_position())
		measure_queue.clear()
	
	if not r_measure_queue.is_empty():
		for name : String in r_measure_queue:
			measure_dictionary[name].queue_free()
		r_measure_queue.clear()
		
	if not metronome:return
	create_oneshot_audio_player(load("res://Music Manager/measure_debug.wav")).play()

##Creates and returns an audio player with the stream "stream" loaded already
##this audio player will automatically kill itself when it finishes playing
func create_oneshot_audio_player(stream: AudioStream) -> AudioStreamPlayer:
	var audio_player := AudioStreamPlayer.new()
	audio_player.stream = stream
	$"Audio Players".add_child(audio_player)
	audio_player.finished.connect(func kys(): audio_player.queue_free())
	return audio_player

##Creates and returns an audio player with the stream "stream" loaded already
func create_audio_player(stream : AudioStream) -> AudioStreamPlayer:
	var audio_player := AudioStreamPlayer.new()
	audio_player.stream = stream
	$"Audio Players".add_child(audio_player)
	return audio_player
