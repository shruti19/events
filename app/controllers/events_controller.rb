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
		if params[:perform] == "attend"
			event = Event.find(params[:id]) 
			# discount = event.discount_applicable? current_user
			current_user.events << event
			current_user.attendees.find_by(event_id: params[:id]).update(
				discount_earned: DISCOUNT_FOR_FEMALE
				) if discount.discount_applicable? current_user
		elsif params[:perform] == "unattend"
			current_user.attendees.where(event_id: params[:id]).destroy_all
		end
	  redirect_to events_path
	end

  def show
  	@event = Event.find(params[:id])
  end

end
