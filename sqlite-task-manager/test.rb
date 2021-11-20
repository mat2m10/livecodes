require "sqlite3"
DB = SQLite3::Database.new("tasks.db")
DB.results_as_hash = true
require_relative 'task'

# READ (One)
# task = Task.find(1)
# puts task.title

# CREATE
# task = Task.new(title: "Fill the beers rack in the fridge", description: "Vegetables should be moved somewhere else.")
# task.save

# UPDATE
# task = Task.find(3)
# task.done = true
# task.save

# READ (All)
# Task.all.each do |task|
#   puts "#{task.id}. [#{task.done ? 'X' : ' ' }] #{task.title}"
# end

# DESTROY
# task = Task.find(2)
# task.destroy
