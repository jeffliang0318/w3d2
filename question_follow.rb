require_relative "questionsDatabase.rb"
require_relative "question.rb"
require_relative "user.rb"

class QuestionFollow

  def initialize(options)
    @author_id = options['author_id']
    @question_id = options['question_id']
  end

  def self.followed_questions_for_question_id(question_id)
    found = QuestionsDatabase.instance.execute(<<-SQL, question_id)
    SELECT
    *
    FROM
    users
    JOIN question_follows ON question_follows.author_id = users.id
    WHERE question_id = ?
    SQL

    found.map{|datum| Users.new(datum)}
  end

  def self.followed_questions_for_user_id(user_id)
    found = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
       *
       FROM
        questions
       JOIN question_follows ON question_follows.question_id = questions.id
       WHERE question_follows.author_id = ?
    SQL
    found.map{|datum| Questions.new(datum)}
  end

end
