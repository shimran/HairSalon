require('spec_helper')

describe(Stylist) do

  describe('#name') do
    it('will return the name of the stylist') do
      test_stylist = Stylist.new({:name => "James Maynard", :phone_number => 5038872974})
      expect(test_stylist.name()).to(eq("James Maynard"))
    end
  end

  describe('#phone_number') do
    it('will return the phone number of the stylist') do
      test_stylist = Stylist.new({:name => "James Maynard", :phone_number => 5038872974})
      expect(test_stylist.phone_number()).to(eq(5038872974))
    end
  end

  describe('#save') do
    it('will save a new stylist into hairsalonx database') do
      test_stylist = Stylist.new({:name => "James Maynard", :phone_number => 5038872974})
      test_stylist.save()
      expect(Stylist.all()).to(eq([test_stylist]))
    end
  end

  describe('.all') do
    it('will have an empty hairsalon database') do
      expect(Stylist.all()).to(eq([]))
    end
  end

  describe('#==') do
    it('will show that Stylist instances with the same details will return as equal') do
      test_stylist1 = Stylist.new({:name => "James Maynard", :phone_number => 5038872974})
      test_stylist2 = Stylist.new({:name => "James Maynard", :phone_number => 5038872974})
      expect(test_stylist1).to(eq(test_stylist2))
    end
  end

  describe(".find") do
    it("returns a stylist instance by his id") do
      test_stylist = Stylist.new({:name => "James Maynard", :phone_number => 5038872974})
      test_stylist.save()
      test_stylist1 = Stylist.new({:name => "Jared Hinrichs", :phone_number => 5037202451})
      test_stylist1.save()
      expect(Stylist.find(test_stylist1.id())).to(eq(test_stylist1))
    end
  end

  describe("#clients") do
    it("returns an array of clients for the stylist") do
      test_stylist = Stylist.new({:name => "James Maynard", :phone_number => 5038872974, :id => nil})
      test_stylist.save()
      test_client1 = Client.new({:name => "Lance Hinrichs", :phone_number => 5039019798, :stylist_id => test_stylist.id()})
      test_client1.save()
      test_client2 = Client.new({:name => "Richard Rethemyer", :phone_number => 4159900464, :stylist_id => test_stylist.id()})
      test_client2.save()
      expect(test_stylist.clients()).to(eq([test_client1, test_client2]))
    end
  end

  describe("#edit") do
    it("lets you edit a stylist's name in the database") do
      test_stylist = Stylist.new({:name => "James Maynard", :phone_number => 5038872974})
      test_stylist.save()
      test_stylist.edit({:name => "Jared Hinrichs"})
      expect(test_stylist.name()).to(eq("Jared Hinrichs"))
    end
  end

  describe("#delete") do
    it("lets you delete a stylist from the database") do
      test_stylist = Stylist.new({:name => "James Maynard", :phone_number => 5038872974})
      test_stylist.save()
      test_stylist1 = Stylist.new({:name => "Jared Hinrichs", :phone_number => 5037202451})
      test_stylist1.save()
      test_stylist.delete()
      expect(Stylist.all()).to(eq([test_stylist1]))
    end
    it("deletes a list's tasks from the database") do
      test_stylist = Stylist.new({:name => "James Maynard", :phone_number => 5038872974})
      test_stylist.save()
      test_client1 = Client.new({:name => "Lance Hinrichs", :phone_number => 321, :stylist_id => test_stylist.id()})
      test_client1.save()
      test_client2 = Client.new({:name => "Richard Rethemyer", :phone_number => 4159900464, :stylist_id => test_stylist.id()})
      test_client2.save()
      test_stylist.delete()
      expect(Client.all()).to(eq([]))
    end
  end
end
