module EventsHelper
	def status event
		if current_user.events.where("events.id=? and due_date >= ? ",event.id, Date.today).present?
	    can 'unattend', event.id
	  else
	    can 'attend', event.id
	  end
	end

	def can perform, event_id
		icn_class = perform == 'attend' ? 'glyphicon-ok' : 'glyphicon-remove'
		link_to( 
			"<span class=''></span> #{perform.capitalize}".html_safe, 
			attend_event_path(id: event_id, perform: perform.to_s), 
			title: perform.capitalize,
			class: perform
			)
	end

	def user_event_status event
		current_user.attendees.find_by(event_id: event.id).present? ? "Attending" : "Not Attending"
	end



end
