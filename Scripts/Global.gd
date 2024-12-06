extends Node

var score = 0
var chestFound = 0
var levels = []
var unlockedLevels = 1

var L1Complete = false 
var L2Complete = false
var L3Complete = false


var maxHealth = 3
var currentHealth = 3


#Persistent skill states
var unlockedDash = false
var unlockedDoubleJump = false
var unlockedWallClimb = false

func reset_skills():
	unlockedDash = false
	unlockedDoubleJump = false
	unlockedWallClimb = false
	unlock_persistent_skills()

func unlock_persistent_skills():
	if unlockedLevels == 2:
		unlockedDash = true
	elif unlockedLevels == 3:
		unlockedDash = true
		unlockedDoubleJump = true
	elif unlockedLevels == 4:
		unlockedDash = true
		unlockedDoubleJump = true
		unlockedWallClimb = true
	else:
		pass
