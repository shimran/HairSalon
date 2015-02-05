require('spec_helper')
describe('Client') do

  describe('#name') do
    it('will return the name of the client') do
      test_client = Client.new({:name => "Jack Johnson", :phone_number => 5030001111})
      expect(test_client.name()).to(eq("Jack Johnson"))
    end
  end

  describe('#phone_number') do
    it('will return the phone number of the client') do
      test_client = Client.new({:name => "Jack Johnson", :phone_number => 5030001111})
      expect(test_client.phone_number()).to(eq(5030001111))
    end
  end

  describe('#save') do
    it('will save the Client into Client table') do
      test_client = Client.new({:name => "Jack Johnson", :phone_number => 5030001111, :stylist_id => 1})
      test_client.save()
      expect(Client.all()).to(eq([test_client]))
    end
  end
  describe('.all') do
    it('will show that the Client table is empty') do
      expect(Client.all()).to(eq([]))
    end
  end
  describe('#==') do
    it('will show that Client instances with the same details will return as equal') do
      test_client1 = Client.new({:name => "Jack Johnson", :phone_number => 5030001111})
      test_client2 = Client.new({:name => "Jack Johnson", :phone_number => 5030001111})
      expect(test_client1).to(eq(test_client2))
    end
  end
  describe(".find") do
    it("returns a barber instance by his id") do
      test_client1 = Client.new({:name => "Jack Johnson", :phone_number => 5030001111, :stylist_id => 2})
      test_client1.save()
      test_client2 = Client.new({:name => "Jared Johnson", :phone_number => 9143303745, :stylist_id => 3})
      test_client2.save()
      expect(Client.find(test_client2.id())).to(eq(test_client2))
    end
  end
  describe("#delete") do
    it("lets you delete a client from the database") do
      test_client = Client.new({:name => "Jack Johnson", :phone_number => 5030001111, :stylist_id => 1})
      test_client.save()
      test_client.delete()
      expect(Client.all()).to(eq([]))
    end
  end
end
