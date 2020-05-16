FactoryBot.define do
  factory :todo_list do
    sequence(:title) { 'Test' }
    sequence(:description){ 'Tests_conf' }
  end
end