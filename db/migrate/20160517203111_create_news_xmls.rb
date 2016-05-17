class CreateNewsXmls < ActiveRecord::Migration
  def change
    create_table :news_xmls do |t|
      t.string :forum
      t.string :forum_title
      t.string :discussion_title
      t.string :language
      t.string :topic_url
      t.text :topic_text
      t.string :spam_score
      t.string :post_num
      t.string :post_id
      t.string :post_url
      t.date :post_date
      t.time :post_time
      t.string :username
      t.text :post
      t.string :country
      t.string :main_image

      t.timestamps null: false
    end
  end
end
