class Clients
  attr_reader(:name, :phone, :client_id)

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
      client_id = client.fetch("client_id").to_i()
      clients.push(Clients.new({:name => name, :phone => phone, :client_id => client_id}))
    end
  clients
  end

  define_method(:save) do
    DB.exec("INSERT INTO clients (name, phone, client_id) VALUES ('#{@name}', '#{@phone}', #{@client_id});")
  end

  define_method(:==) do |another_client|
    self.name().==(another_client.name()).&(self.phone().==(another_client.phone())).&(self.client_id().==(another_client.client_id()))
    end

end
