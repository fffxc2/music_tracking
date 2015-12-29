class DancesSong < ActiveRecord::Base
  belongs_to :dance
  belongs_to :song
end
