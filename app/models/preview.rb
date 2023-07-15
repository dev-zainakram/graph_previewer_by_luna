# == Schema Information
#
# Table name: previews
#
#  id         :bigint           not null, primary key
#  image_url  :string
#  status     :integer
#  url        :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_previews_on_url  (url) UNIQUE
#
class Preview < ApplicationRecord
  enum status: {
    processing: 0,
    processed: 1,
    cancelled: 2
  }

  validates :url, presence: true, uniqueness: true
end
