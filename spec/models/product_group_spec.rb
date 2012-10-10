require 'spec_helper'

describe ProductGroup do
  describe "validations" do
    let(:product_group) { FactoryGirl.create(:product_group) }

    it { product_group.valid?.should be_true }

    # it "should not destroy products" do
    #   FactoryGirl.create(:product, product_group: product_group)
    #   product_group.destroy
    #   Product.count.should be > 0
    # end

    it "should destroy product_groups" do
      FactoryGirl.create(:product_group, alias_name: 'child', parent: product_group)
      product_group.destroy
      ProductGroup.count.should be 0
    end

    context "when not valid" do
      describe "one instance" do
        it "without name" do
          product_group.name = ''
        end

        it "without alias_name" do
          product_group.alias_name = ''
        end

        after(:each) do
          product_group.valid?.should be_false
        end
      end

      describe "several instances" do
        it "with existing alias_name" do
          product_group_1 = FactoryGirl.build(:product_group, alias_name: product_group.alias_name, name: 'new')
          product_group_1.valid?.should be_false
        end
      end
    end
  end
end
