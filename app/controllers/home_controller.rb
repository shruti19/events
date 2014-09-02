class HomeController < ApplicationController

	def index
		@events = Event.list "top_events"
		puts @events.inspect
	end
end
