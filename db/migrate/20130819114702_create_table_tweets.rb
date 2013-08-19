class CreateTableTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :content
      t.belongs_to :twitter_user
      t.timestamps
    end
  end
end
