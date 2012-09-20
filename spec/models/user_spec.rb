require 'spec_helper'

describe User do
  it "should have the roles" do
    User::ROLES.should eq %w(admin manager editor)
  end

  describe "before create" do
    context "when there are no users" do
      it "should set admin role for the first user" do
        user = FactoryGirl.create(:user)
        user.is?(:admin).should be_true
      end
    end

    context "when some users exist" do
      it "should not set admin role" do
        FactoryGirl.create(:user)
        user = FactoryGirl.create(:user, email: 'one@more.user')
        user.is?(:admin).should be_false
      end
    end
  end

  describe "validations" do
    let(:user) { FactoryGirl.build(:user) }
    it { user.should be_valid }

    context "when edited by admin" do
      before { user.edited_by_admin = true }

      it "should not require password" do
        user.password = user.password_confirmation = ''
        user.should be_valid
      end

      it "should not require current_password" do
        user.update_with_password(user.attributes.delete_if { |k, v| User.accessible_attributes.exclude? k }).should be_true
      end
    end
  end

  describe "methods" do
    describe "#roles=" do
      let(:user) { User.new }

      it "should set roles_mask to 1" do
        user.roles = %w(admin)
        user.roles_mask.should be 1
      end

      it "should set roles_mask to 2" do
        user.roles = %w(manager)
        user.roles_mask.should be 2
      end

      it "should set roles_mask to 4" do
        user.roles = %w(editor)
        user.roles_mask.should be 4
      end

      it "should set roles_mask to 6" do
        user.roles = %w(manager editor)
        user.roles_mask.should be 6
      end
    end

    describe "#roles" do
      let(:user) { User.new }

      it "should return %w(manager)" do
        user.roles_mask = 2
        user.roles.should eq %w(manager)
      end

      it "should return %w(manager editor)" do
        user.roles_mask = 6
        user.roles.should eq %w(manager editor)
      end
    end
  end
end
