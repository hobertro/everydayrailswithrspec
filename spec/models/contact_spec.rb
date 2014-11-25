require 'rails_helper'

describe Contact do

  it "is valid with a firstname, lastname and email" do
    contact = Contact.new(
      firstname: 'Aaron',
      lastname:  'Sumner',
      email: 'teste@example.com')
      expect(contact).to be_valid
  end

  it "is invalid without a firstname" do
    contact = Contact.new(firstname: nil)
    contact.valid?
    expect(contact.errors[:firstname]).to include("can't be blank")
  end

  it "is invalid without a lastname" do 
    contact = Contact.new(lastname: nil)
    contact.valid?
    expect(contact.errors[:lastname]).to include("can't be blank")
  end

  it "is invalid without an email address"

  it "is invalid with a duplicate email address" do
    Contact.create(
      firstname: 'Joe',
      lastname: 'Tester',
      email: 'tester@example.com'
      )
    contact = Contact.new(
      firstname: 'Jane',
      lastname: 'Tester',
      email: 'tester@example.com'
      )
    contact.valid?
    expect(contact.errors[:email]).to include("has already been taken")
  end

  it "returns a contact's full name as a string" do
    contact = Contact.new(firstname: "John", lastname: "Doe",
        email: "johndoe@example.com"
      )
    expect(contact.name).to eq('John Doe')
  end

  it "returns a sorted array of results that match" do
    smith = Contact.create(
        firstname: 'John',
        lastname: 'Smith',
        email: "jsmith@example.com"
      )
    jones = Contact.create(
        firstname: 'Tim',
        lastname: 'Jones',
        email: 'tjones@example'
      )
    johnson = Contact.create(
        firstname: 'John',
        lastname: 'Johnson',
        email: 'jjohnson@example.com'
      )
    expect(Contact.by_letter("J")).to eq [johnson,jones]
  end

  it "omits results that do not match" do
     smith = Contact.create(
        firstname: 'John',
        lastname: 'Smith',
        email: "jsmith@example.com"
      )
    jones = Contact.create(
        firstname: 'Tim',
        lastname: 'Jones',
        email: 'tjones@example'
      )
    johnson = Contact.create(
        firstname: 'John',
        lastname: 'Johnson',
        email: 'jjohnson@example.com'
      )
    expect(Contact.by_letter("J")).not_to include smith

  end

  describe "filter last name by letter" do
    before :each do
      @smith = create(:contact,
        firstname: 'John',
        lastname: 'Smith',
        email: 'jsmith@example.com'
      )
      @jones = create(:contact,
        firstname: 'Tim',
        lastname: 'Jones',
        email: 'tjones@example.com'
      )
      @johnson = create(:contact,
        firstname: 'John',
        lastname: 'Johnson',
        email: 'jjohnson@example.com'
      )
    end

    context "with matching letters" do
      it "returns a sorted array of results that match" do
        expect(Contact.by_letter("J")).to eq [@johnson, @jones]
      end
    end

    context "with non-matching letters" do
      it "omits results that do not match" do
        expect(Contact.by_letter("J")).not_to include @smith
      end
    end
  end
=begin 
  it "is has a valid factory" do
    expect(build(:contact)).to be_valid
  end

  it { should validate_presence_of :firstname }
  it { should validate_presence_of :lastname }
  it { should validate_presence_of :email }
  it { should validate_uniqueness_of(:email) }

  it "returns a contact's full name as a string" do
    contact = build_stubbed(:contact,
      firstname: 'Jane',
      lastname: 'Smith'
    )
    expect(contact.name).to eq 'Jane Smith'
  end

  it "has three phone numbers" do
    expect(create(:contact).phones.count).to eq 3
  end

  describe "filter last name by letter" do
    before :each do
      @smith = create(:contact,
        firstname: 'John',
        lastname: 'Smith',
        email: 'jsmith@example.com'
      )
      @jones = create(:contact,
        firstname: 'Tim',
        lastname: 'Jones',
        email: 'tjones@example.com'
      )
      @johnson = create(:contact,
        firstname: 'John',
        lastname: 'Johnson',
        email: 'jjohnson@example.com'
      )
    end

    context "with matching letters" do
      it "returns a sorted array of results that match" do
        expect(Contact.by_letter("J")).to eq [@johnson, @jones]
      end
    end

    context "with non-matching letters" do
      it "omits results that do not match" do
        expect(Contact.by_letter("J")).not_to include @smith
      end
    end
  end
=end
end
