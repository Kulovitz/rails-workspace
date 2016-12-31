class Plan < ActiveRecord::Base
    has_many :users
    
attr_accessor :stripe_card_token
def save_with_subscription
  if valid?
    customer = Stripe::Customer.create(description: email, plan: plan_id, card: stripe_card_token)
    self.stripe_customer_token = customer.id
    save!
  end
end
    
end