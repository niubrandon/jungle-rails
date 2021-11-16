require 'rails_helper'

# Helper functions
def open_asset(file_name)
  File.open(Rails.root.join('db', 'seed_assets', file_name))
end


RSpec.describe Product, type: :model do
  
  subject {
    
    described_class.new(
                        name: "Anything",
                        description: "Anything",
                        image: open_asset('apparel2.jpg'),
                        price_cents: 10000,
                        quantity: 10,
                        category: Category.new(name: "Footware")
                                       
    )
  }

    it "validate the presence of name" do
      subject.name = nil
      subject.validate 
      expect(subject.errors[:name]).to include("can't be blank")
    end

    it "validate the presence of price" do
      subject.price_cents = ""
      subject.validate 
      expect(subject.errors[:price]).to include("can't be blank")
    end

    it "validate the presence of quantity" do
      subject.quantity = nil
      subject.validate 
      expect(subject.errors[:quantity]).to include("can't be blank")
    end
  
    it "validate the presence of category" do
      subject.category = nil
      subject.validate 
      expect(subject.errors[:category]).to include("can't be blank")
    end
end

