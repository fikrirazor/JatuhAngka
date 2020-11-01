extends Node


signal health
signal score
signal level

var health = 3 setget set_health
var score = 0 setget set_score
var level = 0 setget set_level

func reset():
	self.health = 3
	self.score = 0
	self.level = 0

func set_health(new_health):
	health = new_health
	emit_signal("health")

func set_score(new_score):
	score = new_score
	emit_signal("score")

func set_level(new_level):
	level = new_level
	emit_signal("level")
