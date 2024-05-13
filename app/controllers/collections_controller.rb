class CollectionsController < ApplicationController
  belongs_to :user
  has_many :mediums
end
