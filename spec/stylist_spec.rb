require('spec_helper')

describe(Stylists) do

  describe(".all") do
    it('is empty at first') do
      expect(Stylists.all()).to(eq([]))
    end
  end


  describe('#name') do
    it('returns the name of the station') do
      test_stylist= Stylists.new(:name => "John Smith", :id => nil)
      expect(test_stylist.name()).to(eq("John Smith"))
    end
  end

  describe('#stylist_id') do
    it ('returns the employee iD of the stylist') do
      test_stylist = Stylists.new(:name => "John Smith", :id => nil)
      test_stylist.save()
      expect(test_stylist.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe('#save')do
  it('saves each new stylist to the table') do
    test_stylist = Stylists.new({:name => "Kameron Johnson", :id => nil})
    test_stylist.save()
    expect(Stylists.all()).to(eq([test_stylist]))
  end
end

describe('#==') do
  it("is the same stylist if it has the same name and ID") do
    stylist1 = Stylists.new({:name => "Kameron Johnson", :id => 1})
    stylist2 = Stylists.new({:name => "Kameron Johnson", :id => 1})
    expect(stylist1).to(eq(stylist2))
  end
end


end
