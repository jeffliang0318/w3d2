require_relative "questionsDatabase.rb"

class Reply


  def initialize(options)
    @id = options['id']
    @question_id = options['question_id']
    @author_id = options['author_id']
    @body = options['body']
    @top_reply_id = options['top_reply_id']
  end

  def self.find_by_user_id(user_id)
    found = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        replies

      WHERE
        author_id = ?

    SQL

      Reply.new(found.first)
  end

  def self.find_by_question_id(question_id)
    found = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        replies

      WHERE
        question_id = ?
    SQL
    Reply.new(found.first)
  end

  def author
    QuestionsDatabase.instance.execute(<<-SQL, @author_id)
      SELECT
        *
      FROM
        users
      WHERE
        users.id  = ?
    SQL
  end

  def question
    QuestionsDatabase.instance.execute(<<-SQL, @question_id)
      SELECT
        *
      FROM
        questions
      WHERE
        question.id = ?
    SQL

  end

  def parent_reply
    QuestionsDatabase.instance.execute(<<-SQL, @top_reply_id)
      SELECT
        *
      FROM
        replies
      WHERE
        reply.id = ?
    SQL


  end

  def child_replies
    QuestionsDatabase.instance.execute(<<-SQL, @id)
      SELECT
        *
      FROM
        replies
      WHERE
        reply.top_reply_id = ?
    SQL

  end

end
