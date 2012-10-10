# encoding: utf-8

include ActionDispatch::TestProcess

FactoryGirl.define do

  factory :user do
    email "just_a_user@local.ru"
    password "111111"
    password_confirmation "111111"
    name "FN"
    confirmed_at Date.yesterday
  end

  factory :product_group do
    alias_name 'product_group1'
    name 'any product group name'
  end

  factory :product do
    alias_name 'product1'
    name 'any product name'
  end
end

