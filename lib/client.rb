class Client
  attr_reader(:name, :phone_number, :id, :stylist_id)
  define_method(:initialize) do |attributes|
  @name = attributes[:name]
  @phone_number = attributes[:phone_number]
  @id = attributes[:id]
  @stylist_id = attributes[:stylist_id]
end

  define_method(:save) do
    result = DB.exec("INSERT INTO clients (name, phone_number, stylist_id) VALUES ('#{@name}', #{@phone_number}, #{@stylist_id}) RETURNING id;")
    @id = result.first().fetch("id")
  end

  define_singleton_method(:all) do
    client_results = []
    clients = DB.exec("SELECT * FROM clients;")
    clients.each() do |client|
      name = client.fetch("name")
      phone_number = client.fetch("phone_number").to_i()
      id = client.fetch("id")
      stylist_id = client.fetch("stylist_id")
      client_results.push(Client.new({:name => name, :phone_number => phone_number, :id => id, :stylist_id => stylist_id}))
    end
    client_results
  end

  define_method(:==) do |other_client|
    name() == other_client.name() &&
    phone_number() == other_client.phone_number() &&
    id() == other_client.id()
  end

  define_singleton_method(:find) do |id|
    found_client = nil
    Client.all().each() do |client|
      if client.id() == (id)
        found_client = client
      end
    end
    found_client
  end

  define_method(:delete) do
    DB.exec("DELETE FROM clients WHERE id = #{self.id()};")
  end

end
