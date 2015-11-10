class AddCommentToPasswords < ActiveRecord::Migration
        def change
                add_column :passwords, :comment, :text
                add_index :passwords, :url
        end
end
