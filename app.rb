
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
#get('/dog') do
#  @dogs = [
#    {
#      "name" => "hund1",
#      "age" => "ålder1"
#    },
#    {
#      "name" => "hund2",
#      "age" => "ålder2"
#    }
#  ]
#  slim(:dog)  
#
#end