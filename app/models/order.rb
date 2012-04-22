class Order < ActiveRecord::Base
  PAYMENT_TYPES = ['Check', 'Credit card', 'Purchase order']
  attr_accessible :address, :email, :name, :pay_type

  validates :name, :address, :email,
            presence: true
  validates :pay_type, inclusion: PAYMENT_TYPES
end
