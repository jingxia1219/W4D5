# == Schema Information
#
# Table name: goals
#
#  id          :integer          not null, primary key
#  user_id     :integer          not null
#  description :string           not null
#  status      :string           not null
#  privacy     :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Goal < ApplicationRecord
  validates :user_id, :description, :status, :privacy, presence: true

  belongs_to :user
end
