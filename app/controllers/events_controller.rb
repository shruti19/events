class EventsController < ApplicationController

	def index
		@events = Event.where("due_date >= ?", Date.today).order('created_at desc')
		@attending = current_user.events.where("events.due_date >= ?", Date.today)
		if request.xhr?
			puts params[:tab].inspect
			@events = Event.list params[:tab], current_user
			puts @events.inspect
      respond_to do |format|
		    format.html { 
		    	render :partial => 'list', :locals => {:events => @events} 
		    }
		  end
		end
	end

	def attend
		current_user.events << Event.find(params[:id]) if params[:perform] == "attend"
		current_user.attendees.where(event_id: params[:id]).destroy_all if params[:perform] == "unattend"
	  redirect_to events_path
	end

  def show
  	@event = Event.find(params[:id])
  end

end
