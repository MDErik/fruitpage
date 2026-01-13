
require 'sinatra'
require 'slim'
require 'sinatra/reloader'
require 'sqlite3'


get('/fruits') do
  #gör en koppling till databasen
  db = SQLite3::Database.new("db/fruits.db")
   
  db.results_as_hash = true
  #hämta allting från db 
  @datafrukt = db.execute("SELECT * FROM fruits")

  p @datafrukt

  query = params[:q]

  if query && !query.empty?
    @datafrukt = db.execute("SELECT * FROM fruits WHERE name LIKE ?", "%#{query}%")
  else
    @datafrukt = db.execute("SELECT * FROM fruits")
  end
  #visa upp med slim
  slim(:"fruits/index")

end


get('/fruits/new') do 
  new_fruit = params[:new_fruit]
  amount = params[:amount].to_i

  slim(:"fruits/new")
end

post('/fruit') do 
  new_fruit = params[:new_fruit]
  amount = params[:amount].to_i 
  db = SQLite3::Database.new('db/fruits.db')
  db.execute("INSERT INTO fruits (name, amount) VALUES (?,?)",[new_fruit,amount])
  redirect('/fruits')
end
 
 
get('/animals') do
  db = SQLite3::Database.new("db/animals.db")
   
  db.results_as_hash = true

  @animaldata = db.execute("SELECT * FROM animals")

  p @animaldata

  query = params[:q]

  if query && !query.empty?
    @animaldata = db.execute("SELECT * FROM animals WHERE name LIKE ?", "%#{query}%")
  else
    @animaldata = db.execute("SELECT * FROM animals")
  end

  slim(:animals)
end

get('/newnew') do
  new_animal = params[:new_animal]
  amount = params[:amount].to_i



  slim(:newnew)
end

post('/') do
  new_fruit = params[:new_fruit]
  amount = params[:amount].to_i 
  db = SQLite3::Database.new('db/animals.db')
  db.execute("INSERT INTO animals (name, amount) VALUES (?,?)",[new_animal,amount])
  redirect('/fruits')


end

post('/fruits/:id/delete') do
  du_ska_bort = params[:id].to_i
  db = SQLite3::Database.new('db/fruits.db')

  db.execute("DELETE FROM fruits WHERE id = ?", du_ska_bort)
  
  redirect('/fruits')
end

get('/fruits/:id/edit') do
  id = params[:id].to_i
  db = SQLite3::Database.new('db/fruits.db')
  db.results_as_hash = true
  @info = db.execute("SELECT * FROM fruits WHERE id = ?",id).first
  slim(:'fruits/edit')

end

post('/fruits/:id/update') do
  db = SQLite3::Database.new('db/fruits.db')
  amount = params[:amount]
  id = params[:id].to_i
  name = params[:name]
  db.execute("UPDATE fruits SET name=?, amount=? WHERE id=?", [name,amount,id])
  redirect('/fruits')

end

#get('/') do
#  slim(:start)
#
#end
#
#get('/bye') do
#  slim(:bye)
#
#end
#
#
# 
# get('/frukt/:id') do
#  fruits = ["Äpple","Banan","Apelsin"]
#  id = params[:id].to_i
#  @Fruit = fruits[id]
#  slim(:frukt)
#  
#end
#
#
#
