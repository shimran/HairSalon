class Clients
  attr_reader(:name, :phone)

  define_method (:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @phone = attributes.fetch(:phone)
  end



  define_singleton_method(:all) do
    returned_clients = DB.exec("SELECT * FROM clients")
    clients = []
    returned_clients.each() do |client|
    name = client.fetch("name")
    phone = client.fetch("phone")
    clients.push(Clients.new({:name => name, :phone => phone}))
    end
  clients
  end

  define_method(:save) do
    DB.exec("INSERT INTO clients (name, phone) VALUES ('#{@name}', '#{@phone}');")
  end

  define_method(:==) do |another_client|
    self.name().==(another_client.name()).&(self.phone().==(another_client.phone()))
    end

end
