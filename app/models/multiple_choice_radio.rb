class MultipleChoiceRadio < QuizQuestion
  include ActionView::Helpers::FormHelper

  def edit(count)
    @question = self
    questionnum = @question.id

    html = ""

    #QuizQuestion needs to do some generic stuff before and after,
    #so we call it with a block.
    super(count) do |common_html|
      html += common_html

      #@quiz_question_choices = QuizQuestionChoice.where(question_id: @question.id)
      @quiz_question_choices = @question.quiz_question_choices

      i = 1
      for @quiz_question_choice in @quiz_question_choices
        html += "<tr><td>&nbsp;&nbsp;&nbsp;"

        html += radio_button_tag("quiz_question_choices[#{questionnum}][MultipleChoiceRadio][correctindex]", "#{i}", @quiz_question_choice.iscorrect)
        html += "&nbsp;" + text_field_tag("quiz_question_choices[#{questionnum}][MultipleChoiceRadio][#{i}][txt]", @quiz_question_choice.txt, :size=>40)

        html += "</td></tr>"

        i += 1
      end
    end

    html.html_safe
  end

  def complete(count, answer=nil)
    @question = self
    html = ""
    html += label_tag("#{@question.id}", @question.txt)
    html +=  "</br>"

    quiz_question_choices = QuizQuestionChoice.where(question_id: @question.id)
    quiz_question_choices.each do |choice|
      if answer=="view"
        html += radio_button_tag("#{@question.id}", "#{choice.txt}", choice.iscorrect)
        html += label_tag("#{choice.id}", choice.txt)
        html += "<br>"
      end
      if answer=="take"
        html += radio_button_tag("#{@question.id}", "#{choice.txt}")
        html += label_tag("#{choice.id}", choice.txt)
        html += "<br>"
      end
    end
    html += "</br>"
    html.html_safe
  end

  def view_completed_question(count, answer)
    @question = self

    html = ""
    html += "</br>"
    QuizQuestionChoice.where(question_id: @question.id).each do |q_answer|
      if q_answer.iscorrect
        html += "<b>" + q_answer.txt + "</b> -- Correct </br>"
      else
        html+= q_answer.txt + "</br>"
      end
    end
    html+= "<br>"

    html+= "Your answer is: <b>" + answer.first.comments + "</b>"
    if answer.first.answer==1
      html+= "<img src=/assets/Check-icon.png/>"
    else
      html+= "<img src=/assets/delete_icon.png/>"
    end
    html+= "<br>"
    html.html_safe
  end
end
