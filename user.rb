require_relative "questionsDatabase"
require_relative "question_follow"


class Users
  attr_accessor :id, :fname, :lname

  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

  def self.find_by_name(fname, lname)
    found = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
      SELECT
        *
      FROM
        users

      WHERE
        fname = ? AND lname = ?

    SQL

      Users.new(found.first)
  end

  def follow_questions
    @question = QuestionFollow.followed_questions_for_user_id(@id)

  end


  def followers

    QuestionFollow.followed_questions_for_question_id(@question.id)
  end

end
