require('spec_helper')

describe(Clients) do
  describe(".all") do
    it('is empty at first') do
    expect(Clients.all()).to(eq([]))
    end
  end

  describe("#save") do
    it("adds a client to the client [] array") do
      test_client = Clients.new({:name => "James Maynard", :phone => "5038872974", :client_id => nil})
      test_client.save()
      expect(Clients.all()).to(eq([test_client]))
    end
  end

  describe('#name') do
    it('returns the name of the client') do
      test_client= Clients.new(:name => "James Maynard", :phone => "5038872974",:client_id => nil)
      expect(test_client.name()).to(eq("James Maynard"))
    end
  end

  describe('#phone') do
    it('returns the phone number of the client') do
      test_client= Clients.new(:name => "James Maynard", :phone => "5038872974",:client_id => nil)
      expect(test_client.phone()).to(eq("5038872974"))
    end
  end

  describe("#==") do
    it("is the same client if it has the same name and phone number") do
      client1 = Clients.new({:name => "James Maynard", :phone => "5038872974", :client_id => nil})
      client2 = Clients.new({:name => "James Maynard", :phone => "5038872974", :client_id => nil})
      expect(client1).to(eq(client2))
    end
  end


end
