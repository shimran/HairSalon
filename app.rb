require('sinatra')
require('sinatra/reloader')
require('./lib/stylist')
require('./lib/client')
also_reload('lib/**/*.rb')
require('pg')

DB = PG.connect({:dbname => "hair_salon"})

get("/") do
  @stylists = Stylist.all()
  erb(:index)
end

post("/stylists") do
  name = params.fetch("name")
  phone_number = params.fetch("phone_number")
  stylist = Stylist.new({:name => name, :phone_number => phone_number, :id => nil})
  stylist.save()
  @stylists = Stylist.all()
  redirect '/'
end

get("/stylists/:id") do
  @stylist = Stylist.find(params.fetch("id"))
  erb(:stylists)
end

post("/clients") do
  name = params.fetch("name")
  phone_number = params.fetch("phone_number")
  stylist_id = params.fetch("stylist_id")
  client = Client.new({:name => name, :phone_number => phone_number, :stylist_id => stylist_id})
  client.save()
  @clients = Client.all()
  redirect back
end

post("/clients-h") do
  name = params.fetch("name")
  phone_number = params.fetch("phone_number")
  stylist_id = params.fetch("stylist_id")
  client = Client.new({:name => name, :phone_number => phone_number, :stylist_id => stylist_id})
  client.save()
  @clients = Client.all()
  erb(:index)
end

get("/stylists/:id/edit") do
  @stylist = Stylist.find(params.fetch("id"))
  erb(:stylist_change)
end

patch("/stylists/:id") do
  name = params.fetch("name")
  @stylist = Stylist.find(params.fetch("id"))
  @stylist.edit({:name => name})
  erb(:stylists)
end

delete("/stylists/:id") do
  @stylist = Stylist.find(params.fetch("id"))
  @stylist.delete()
  @stylists = Stylist.all()
  redirect '/'
end

delete("/stylists-1/:id") do
  @stylist = Stylist.find(params.fetch("id"))
  @stylist.delete()
  @stylists = Stylist.all()
  erb(:index)
end

delete("/clients/:id") do
  @client = Client.find(params.fetch("id"))
  @client.delete()
  @clients = Client.all()
  redirect back
end
