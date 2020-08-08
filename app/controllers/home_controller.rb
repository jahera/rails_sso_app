class HomeController < ApplicationController
  before_action :authenticate_user!, except: [:profile] 
	def index
	end
end
