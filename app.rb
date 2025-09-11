require 'sinatra'
require 'slim'
require 'sinatra/reloader'

get('/') do
  slim(:start)

end

get('/bye') do
  slim(:bye)

end

get('/fruits') do
  @fruits = ["Äpple","Banan","Apelsin"]
  slim(:fruits)
 end
 
 get('/frukt/:id') do
  fruits = ["Äpple","Banan","Apelsin"]
  id = params[:id].to_i
  @Fruit = fruits[id]
  slim(:frukt)
  
end
