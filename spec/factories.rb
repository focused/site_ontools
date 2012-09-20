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

end

