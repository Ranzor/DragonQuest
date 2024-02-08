extends Node2D

@export var spawnPos : Vector2
var prevLoc: String
var curLoc: String
var spawnAnim : String = "walk_down"
var canTravel: bool = true
var canMove: bool = true
