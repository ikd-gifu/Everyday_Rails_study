FactoryBot.define do
  factory :user do
    first_name { "Aaron" }
    last_name { "Summer" }
    seqence(:email) { |n| "tester#{n}@example.com" }
    password { "dottle-nouveau-pavilion-tighit-furze" }
  end
end
