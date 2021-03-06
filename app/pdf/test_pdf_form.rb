class TestPdfForm < FillablePdfForm

  def initialize(user, course)
    @user = user
    @course = course
    super(@course)
  end

  protected

  def fill_out
    fill :date, Date.today.strftime("%B %d, %Y")
    fill :course_title, @course.title
    fill :first_name, @user.first_name
    fill :last_name, @user.last_name
    if @course.author_type == "User"
      fill :author, "#{@course.author.first_name} #{@course.author.last_name}"
    else
      fill :author, "#{@course.author.title}"
    end
  end
end