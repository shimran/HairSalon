require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/stylists")
require("./lib/clients")
require("pg")

DB = PG.connect({:dbname => "hair_salon"})

get("/") do
  @stylists = Stylists.all()
  erb(:index)
end

post("/stylists") do
  name = params.fetch("name")
  stylists = Stylists.new({:name => name, :id => nil})
  stylists.save()
  @stylists = Stylists.all()
  erb(:index)
end
