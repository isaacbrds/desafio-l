FactoryBot.define do
  factory :task do
    sequence :title do |n|
      "Title #{n}."
    end
    sequence :description do |n|
      "Description Marota #{n}."
    end
    
    share {false}
  end
end
