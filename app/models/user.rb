class User < ApplicationRecord
  validates :name, :length => 1..20, presence: true
  validates :email, :format => /@/
end
