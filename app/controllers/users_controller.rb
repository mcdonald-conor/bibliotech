class UsersController < ApplicationController
  has_many :collections
  has_many :mediums
end
