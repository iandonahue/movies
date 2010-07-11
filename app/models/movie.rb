# == Schema Information
# Schema version: 20100709210545
#
# Table name: movies
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  release    :date
#  desription :text
#  created_at :datetime
#  updated_at :datetime
#

class Movie < ActiveRecord::Base
end
