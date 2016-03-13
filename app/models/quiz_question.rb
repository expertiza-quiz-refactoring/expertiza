class QuizQuestion < Question
  has_many :quiz_question_choices, :class_name => 'QuizQuestionChoice', :foreign_key => 'question_id'
  def edit
  end

  def view_question_text
    html = self.txt + '<br />'
    if self.quiz_question_choices
      self.quiz_question_choices.each do |choices|
        if choices.iscorrect?
          html += "  - <b>"+choices.txt+"</b><br /> "
        else
          html += "  - "+choices.txt+"<br /> "
        end
      end
      html += '<br />'
    end
    html.html_safe
  end

  def complete
  end

  def view_completed_question
  end

end
