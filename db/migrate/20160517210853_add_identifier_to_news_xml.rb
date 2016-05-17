class AddIdentifierToNewsXml < ActiveRecord::Migration
  def change
    add_column :news_xmls, :identifier, :string
  end
end
