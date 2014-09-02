class AddColumnGenderToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :gender, :string#, :limit => [:male, :female]
  	add_column :events, :fee, :integer
  	add_column :events, :discount, :float
  	add_column :attendees, :discount_earned, :float
  end
end
