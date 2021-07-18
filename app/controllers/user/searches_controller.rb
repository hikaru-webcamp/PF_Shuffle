class User::SearchesController < ApplicationController
  include Search
  before_action :search
end
