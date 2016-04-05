require 'test_helper'

class ChefTest < ActiveSupport::TestCase
  
  def setup
    @chef = Chef.new(chefname: "Kevin", email: "kevin@example.com")
  end
  
  test "chef should be valid" do
    assert @chef.valid?
  end
  
  test "chefname should be present" do
    @chef.chefname = " "
    assert_not @chef.valid?
  end
  
  test "chefname should not be too long" do
    @chef.chefname = "a" * 41
    assert_not @chef.valid?
  end
  
  test "chefname should not be too short" do
    @chef.chefname = "a" * 2
    assert_not @chef.valid?
  end
  
  test "email must be present" do
    @chef.email = " "
    assert_not @chef.valid?
  end
  
  test "email length should be within bounds" do
    @chef.email = "a" * 101 + "@example.com"
    assert_not @chef.valid?
  end
  
  test "email address should be unique" do
    dup_chef = @chef.dup
    dup_chef.email = @chef.email.upcase
    @chef.save
    assert_not dup_chef.valid?
  end
  
  test "email validation should accept valid email addresses" do
    valid_addresses = %w[user@eee.com R_TDD-DS@eee.hello.org user@example.com first.last@exmpl.au kevin+meg@bbc.uk]
    valid_addresses.each do |address|
      @chef.email = address
      assert @chef.valid?, '#{address.inspect} should be valid'
    end
  end
  
  test "email validation should reject valid email addresses" do
    invalid_addresses = %w[user@example,com user_at_fake.com user.name@example. fake@fa_ke_.com foo@b+ar.com]
    invalid_addresses.each do |address|
      @chef.email = address
      assert_not @chef.valid?, '#{address.inspect} should be invalid'
    end
  end
  
end
