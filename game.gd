extends Control
const SCREEN_HEIGHT = 600
const SCREEN_WIDTH = 1024
onready var bolas = load("res://src/Object/bolapertanyaan.tscn")
var delaytime = 1


onready var perhitungan = load("res://src/Game/perhitungan.gd")

onready var healthbar = $healthbar
onready var p1 = $Pertanyaan
onready var p2 = $Pertanyaan2
onready var p3 = $Pertanyaan3
onready var p4 = $Pertanyaan4
onready var p5 = $Pertanyaan5

var nilaiAwal
var nilaiAkhir

#method penjumlahan
func tambah(a,b):
	return a+b

# Called when the node enters the scene tree for the first time.
func _ready():
	$".".mouse_filter = MOUSE_FILTER_IGNORE
	mulai()
	$MobTimer.set_wait_time(delaytime)
	$MobTimer.start()
	randomize()
	_spawn()
	$healthbar.set_text("HP : "+str(Global.health))
	#var bola = bolas.instance()
	#var pos = Vector2()
	#bola.position = Vector2(rand_range(0, 1024), 0)
	#add_child(bola)
	#bola.set_axis_velocity(Vector2(0,100))
	#bola.connect("input_event", self, "_on_bolapertanyaan_input_event")

func mulai():
	$Timer.start()
	pertanyaan()
	

func _set_pertanyaan(a,b,labelpertanyaan):
	var pertanyaan = labelpertanyaan
	var text = str(a, "  +  " , b )
	pertanyaan.set_text(text)

func _set_random_number():
	var i = 0 
	if i<=10:
		nilaiAwal = 0
		nilaiAkhir = 10
	var rand = RandomNumberGenerator.new()
	rand.randomize()
	var a = rand.randi_range(nilaiAwal,nilaiAkhir)
	return a

func game():
	var pt = perhitungan.new()
	var a = _set_random_number()
	var b = _set_random_number()
	var hasil = pt.tambah(a,b)
	_set_pertanyaan(a,b,p1)
	return hasil

func pertanyaan():
	var i = 0
	if i <= 10:
		nilaiAwal = 0
		nilaiAkhir = 10
	var rand = RandomNumberGenerator.new()
	rand.randomize()
	var a = rand.randi_range(nilaiAwal,nilaiAkhir)
	rand.randomize()
	var b = rand.randi_range(nilaiAwal,nilaiAkhir)

func _set_jawaban_benar():
	return 6

func _spawn_fake():
	randomize()
	var bola = bolas.instance()
	var pos = Vector2()
	bola.position = Vector2(rand_range(0, 1024), 0)
	bola.set_text(str(23))
	add_child(bola)
	bola.set_axis_velocity(Vector2(0,100))
	bola.connect("tes", self, "kurang_darah")
	bola.connect("game_over",self, "game_over")

func kurang_darah():
	Global.health -= 1
	$healthbar.set_text("HP : "+str(Global.health))
	var health = Global.health

func _spawn():
	randomize()
	var bola = bolas.instance()
	var pos = Vector2()
	bola.position = Vector2(rand_range(0, 1024), 0)
	bola.set_text(str(game()))
	add_child(bola)
	bola.set_axis_velocity(Vector2(0,100))
	bola.connect("tes", self, "spawn_again")
	bola.connect("game_over",self, "game_over")

func spawn_again():
	_spawn()

func touch_input():
	if Input.is_action_just_pressed("ui_touch"):
		queue_free()

#func _on_MobTimer_timeout():
	#spawn()

func game_over():
	get_tree().change_scene("res://Menu_Screen.tscn")

func _on_MobTimer_timeout():
	_spawn_fake()
