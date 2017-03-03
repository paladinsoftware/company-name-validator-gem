require 'spec_helper'

class TestUser < TestModel
  validates :company, company: true
end

class TestComapny < TestModel
  validates :name, company: true
end

describe CompanyValidator do

  describe "validation" do
    context "given the valid names" do
      [
        "Bent Pixels",
        "2btube",
        "PaladinSoftware"
      ].each do |name|

        it "#{name.inspect} should be valid" do
          expect(TestUser.new(:company => name)).to be_valid
        end

        it "#{name.inspect} should be valid in strict_mode" do
          expect(TestComapny.new(:name => name)).to be_valid
        end

        it "#{name.inspect} should match the regexp" do
          expect(name =~ CompanyValidator::REGEXP).to be_truthy
        end
      end
    end

    context "given the invalid names" do
      [
        "",
        "BentPixles",
        "PALADINDSOFTWARE",
        "123123",

      ].each do |name|

        it "#{name.inspect} should not be valid" do
          expect(TestUser.new(:company => name)).not_to be_valid
        end

        it "#{name.inspect} should not be valid in strict_mode" do
          expect(TestComapny.new(:name => name)).not_to be_valid
        end

        it "#{name.inspect} should not match the regexp" do
          expect(name =~ CompanyValidator.regexp).to be_falsy
        end


        it "#{name.inspect} should fail the class tester" do
          expect(CompanyValidator.valid?(name)).to be_falsy
        end

      end
    end
  end

  # describe "error messages" do
  #   context "when the message is not defined" do
  #     subject { TestUser.new :name => 'invalidname@' }
  #     before { subject.valid? }

  #     it "should add the default message" do
  #       expect(subject.errors[:name]).to include "is invalid"
  #     end
  #   end

  #   context "when the message is defined" do
  #     subject { TestUserWithMessage.new :name_address => 'invalidname@' }
  #     before { subject.valid? }

  #     it "should add the customized message" do
  #       expect(subject.errors[:name_address]).to include "is not looking very good!"
  #     end
  #   end
  # end

  # describe "nil name" do
  #   it "should not be valid when :allow_nil option is missing" do
  #     expect(TestUser.new(:name => nil)).not_to be_valid
  #   end

  #   it "should be valid when :allow_nil options is set to true" do
  #     expect(TestUserAllowsNil.new(:name => nil)).to be_valid
  #   end

  #   it "should not be valid when :allow_nil option is set to false" do
  #     expect(TestUserAllowsNilFalse.new(:name => nil)).not_to be_valid
  #   end
  # end

  # describe "default_options" do
  #   context "when 'name_validator/strict' has been required" do
  #     before { require 'name_validator/strict' }

  #     it "should validate using strict mode" do
  #       expect(TestUser.new(:name => "&'*+-./=?^_{}~@other-valid-characters-in-local.net")).not_to be_valid
  #     end
  #   end
  # end
end
