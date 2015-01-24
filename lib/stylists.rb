class Stylists
    attr_reader(:name, :id)

    define_method(:initialize) do |attributes|
      @name = attributes.fetch(:name)
      @id = attributes.fetch(:id)
    end

    define_singleton_method(:all) do
      returned_stylists = DB.exec("SELECT * FROM stylists;")
      stylists = []
      returned_stylists.each() do |sylist|
        name = sylist.fetch("name")
        id = sylist.fetch("id").to_i()
        stylists.push(Stylists.new({:name => name, :id => id}))
      end
      stylists
    end

    define_method(:save) do
      result = DB.exec("INSERT INTO stylists (name) VALUES ('#{@name}') RETURNING id;")
      @id = result.first().fetch("id").to_i()
    end

    define_singleton_method(:find) do |id|
      found_stylist = nil
      Stylists.all().each() do |stylist|
        if stylist.id().==(id)
          found_stylist = stylist
        end
      end
      found_stylist
    end

    define_method(:clients) do
      list_clients = []
      clients = DB.exec("SELECT * FROM clients WHERE client_id = #{self.id()};")
      clients.each() do |client|
        name = client.fetch("name")
        phone = client.fetch("phone")
        client_id = task.fetch("client_id").to_i()
        list_clients.push(Clients.new({:name => name, :phone => phone, :client_id => client_id}))
      end
      list_clients
    end
    define_method(:==) do |another_stylist|
      self.name().==(another_stylist.name()).&(self.id().==(another_stylist.id()))
    end
  end
