require 'sqlite3'

db = SQLite3::Database.new("animals.db")

db.execute <<-SQL
  CREATE TABLE IF NOT EXISTS animals (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    amount INTEGER NOT NULL
  );
SQL

db.execute("DELETE FROM animals")  # Rensa tabellen först

animals = [
  ['Elephant',16], 
  ['Raindeer',32], 
  ['Gorilla',64], 
  ['Cat',128]
]

animals.each do |animal|
  db.execute("INSERT INTO animals (name,amount) VALUES (?,?)", animal)
end

puts "Seed data inlagd."