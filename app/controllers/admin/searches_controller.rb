class Admin::SearchesController < ApplicationController
  include Search
  before_action :search
end
