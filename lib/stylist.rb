class Stylist
  attr_reader(:name, :phone_number, :id)

  define_method(:initialize) do |attributes|
    @name = attributes[:name]
    @phone_number = attributes[:phone_number]
    @id = attributes[:id]
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO stylists (name, phone_number) VALUES ('#{@name}', #{@phone_number}) RETURNING id;")
    @id = result.first().fetch("id")
  end

  define_singleton_method(:all) do
    stylist_results = []
    stylists = DB.exec("SELECT * FROM stylists;")
    stylists.each() do |stylist|
      name = stylist.fetch("name")
      phone_number = stylist.fetch("phone_number").to_i()
      id = stylist.fetch("id")
    stylist_results.push(Stylist.new({:name => name, :phone_number => phone_number, :id => id}))
    end
    stylist_results
  end

  define_method(:==) do |other_stylist|
    name() == other_stylist.name() &&
    phone_number() == other_stylist.phone_number() &&
    id() == other_stylist.id()
  end

  define_singleton_method(:find) do |id|
    found_stylist = nil
    Stylist.all().each() do |stylist|
      if stylist.id() == (id)
        found_stylist = stylist
      end
    end
    found_stylist
  end

  define_method(:clients) do
    stylist_clients = []
    clients = DB.exec("SELECT * FROM clients where stylist_id = #{self.id()};")
    clients.each() do |client|
      name = client.fetch("name")
      phone_number = client.fetch("phone_number").to_i()
      id = client.fetch("id")
    stylist_id = client.fetch("stylist_id")
    stylist_clients.push(Client.new({:name => name, :phone_number => phone_number, :id => id, :stylist_id => stylist_id}))
    end
    stylist_clients
  end

  define_method(:edit) do |attributes|
    @name = attributes[:name]
    @id = self.id()
    DB.exec("UPDATE stylists SET name = '#{@name}' WHERE id = #{@id};")
  end

  define_method(:delete) do
    DB.exec("DELETE FROM stylists WHERE id = #{self.id()};")
    DB.exec("DELETE FROM clients WHERE stylist_id = #{self.id()};")
  end
end
