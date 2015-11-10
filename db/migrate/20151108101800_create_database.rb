class CreateDatabase < ActiveRecord::Migration
        def change
                create_table :passwords do |t|
                        t.string :url
                        t.binary :encrypted
                        t.binary :iv
                        t.binary :salt
                        t.timestamps
                end
        end
end
