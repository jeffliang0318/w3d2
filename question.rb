require_relative 'questionsDatabase'

class Questions

  attr_accessor :id
  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @author_id = options['author_id']
  end

  def self.all
    data = QuestionsDatabase.instance.execute("SELECT * FROM questions")
    p data.map { |datum| Questions.new(datum) }
  end

  def self.find_by_id(id)
    # raise "ID is not existed" unless @ids
    found = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        questions
      WHERE
        id = ?
    SQL

      Questions.new(found.first)
  end

  def self.find_by_author_id(author_id)

    found = QuestionsDatabase.instance.execute(<<-SQL, author_id)
      SELECT
       *
      FROM
        questions
      WHERE
        author_id = ?
    SQL

    raise " no id found " if found.emtpy?
  end


  def author
    found = QuestionsDatabase.instance.execute(<<-SQL , @author_id)
      SELECT
        fname, lname
      FROM
        users
      Where
        Users.id = ?
    SQL

  end


  def replies
    


  end


end
