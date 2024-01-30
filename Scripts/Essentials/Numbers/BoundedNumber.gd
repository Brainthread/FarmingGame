extends Node
class_name BoundedNumber 
# BoundedNumber! Perfect for Level counters and other such nonsense. 
# Also works wonders for alertness statuses and similar

signal numbered_up
signal numbered_down
signal number_set

@export var min_number:int = 1
@export var number:int = 1
@export var max_number:int = 5

func number_change_is_valid (change:int):
	var new_number = number + change
	return number_is_valid(new_number)

func number_is_valid (number:int):
	return number <= max_number and number > 0
	
func number_up ():
	if number_change(1):
		numbered_up.emit()
		return true
	return false

func number_change (change:int):
	if number_change_is_valid(change):
		number = number + change
		return true
	return false
	
func set_number (new_number:int):
	if number_is_valid(new_number):
		number = new_number
		number_set.emit()
		return true
	return false
