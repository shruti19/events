class EventsController < ApplicationController
  
  before_action :authenticate_user

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
		begin
			event = Event.find(params[:id])
			if params[:perform] == "attend"
				notice = "You participation in event #{event.name} is recorded."
				current_user.events << event
				current_user.attendees.find_by(event_id: params[:id]).update(
					discount_earned: DISCOUNT_FOR_FEMALE
					) if event.discount_applicable? current_user
			elsif params[:perform] == "unattend"
				notice = "You participation in event #{event.name} has been removed. You may change your participation status anytime later."
				current_user.attendees.where(event_id: params[:id]).destroy_all
			end
	    redirect_to events_path, flash: {notice: notice}
		rescue Exception => e
			errors = "Request.failed due to following error(s): #{e.message.inspect}"
	    redirect_to events_path, flash: {error: errors}
		end
	end

  def show
  	@event = Event.find(params[:id]) rescue nil
  	redirect_to events_path, flash: {error: "Bad Request"} if @event.nil?
  end

  private

  def authenticate_user 
 	  redirect_to root_path, flash: {error: "Request unauthorized!"} if current_user.nil?
  end


end
