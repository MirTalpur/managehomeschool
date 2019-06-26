class Homework < ApplicationRecord
  belongs_to :student
  belongs_to :course, optional: true
end
