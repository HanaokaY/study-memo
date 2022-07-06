require 'sqlite3'


class Entity
    attr_reader :table, :ident
    @@db = SQLite3::Database.new 'test.db'
    
    def initialize(table, ident)
        @table = table
        @ident = ident
        @@db.execute("INSERT INTO #{@table} (id) VALUES(#{@ident})")
    end

    def set(col,val)
        p "親クラスのsetメソッドの中で#{col}と#{val}を受け取っている"
        @@db.execute("UPDATE #{@table} SET #{col}='#{val}' WHERE id=#{@ident}")
    end

    def get(col)
        @@db.execute(("SELECT #{col} FROM #{@table} WHERE id=#{@ident}")[0][0])
    end

end


class Movie < Entity

    def initialize(ident)
        super("movies", ident)
    end

    def title
        get "title"
    end

    def title=(value)
        p 'Movieクラスのtitleメソッド'
        p value
        set "title", value
    end

    def derector
        get "director"
    end

    def director=(value)
        set "director", value
    end

end


movie = Movie.new(3)
movie.title = "くれよんしんちゃん"
movie.director = "スタンリー・キューブリック"






