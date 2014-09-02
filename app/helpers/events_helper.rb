module EventsHelper
	def status event
		if current_user.events.where("events.id=?",event.id).present?
	    can 'unattend', event.id
	  else
	    can 'attend', event.id
	  end
	end

	def can perform, event_id
		icn_class = perform == 'attend' ? 'glyphicon-ok' : 'glyphicon-remove'
		link_to( 
			"<span class='glyphicon #{icn_class}'></span> #{perform.capitalize}".html_safe, 
			attend_event_path(id: event_id, perform: perform.to_s), 
			title: perform.capitalize,
			class: 'action_items ' + perform
			)
	end
end
