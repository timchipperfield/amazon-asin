FactoryBot.define do
  factory :product do
    title { "Star Wars Lego" }
    rank  { 4.2 }
    category { "toys" }
    asin { "BK342UUII" }
    dimensions { "32 in x 45 in" }
  end
end
