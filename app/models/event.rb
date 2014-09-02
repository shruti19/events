class Event < ActiveRecord::Base
	has_many :attendees, dependent: :destroy
	has_many :users, through: :attendees

  # top_events_threshold = 1

	def self.list tab, current_user=nil
		if tab == "all"
			where("due_date >= ?", Date.today).order('created_at desc')
		elsif tab == "top_events"
			top_event_ids = []
			hash_of_top_events = Attendee.where.not(
				"id in (?)", Event.past_events.collect(&:id)).group(:event_id
				).count.reject{|k,v| v < 1 }
			hash_of_top_events.sort_by{|k,v| v }.reverse.each do |event_id|
			  top_event_ids << event_id[0] 
			end
			orderd_list top_event_ids
		elsif tab == "attending" && current_user.present?
			current_user.events.where("events.due_date >= ?", Date.today)
		end
	end

	## Get array of top events in a hash in the form of {event.id => event}. 
	## We want the list to be sorted in order given in order_ref array so we map with order_ref
	def self.orderd_list order_ref
		events_hash = Event.where("id in (?)", order_ref).each_with_object({}) do |event, hash| 
		  hash[event.id] = event if event.present?
		end
		order_ref.map { |index| events_hash[index] }
	end
 
	# ## set criteria for top events and reject events below this criteria
	# def self.top_events_threshold
	# 	1
	# end
    
  def discount_applicable? current_user
    (current_user.gender.to_s == "female" && discount.present?) ? discount : nil
  end
 
  def process_discount
    (discount.present? && fee.present?) ? (discount.to_f/100)*fee : nil
  end
  
  def self.past_events
  	where.not("due_date >= ?", Date.today)
  end
end