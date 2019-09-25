require 'pry'

class Pokemon
    attr_accessor :id, :name, :type, :db

    def initialize(id:nil, name:, type:, db:)
        @id = id
        @name = name
        @type = type
        @db = db
    end

    # Here we're inserting a row into our pokemon database (whether or not that pokemon instance has already been initialized)
    def self.save(name, type, db)
        sql = <<-SQL
            INSERT INTO pokemon (name, type) VALUES (?, ?)
        SQL

        db.execute(sql, name, type)
    end

    # Here we're grabbing a row from our pokemon database and making a new instance of pokemon from it
    def self.find(id, db)
        sql = <<-SQL
            SELECT * FROM pokemon WHERE id = ?
        SQL

        pokemon = db.execute(sql, id).flatten
        
        Pokemon.new(id: pokemon[0], name: pokemon[1], type: pokemon[2], db: db)
    end
end
