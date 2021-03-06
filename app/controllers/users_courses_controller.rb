class UsersCoursesController < ApplicationController
  before_action :set_course_and_user, only:[:start_course, :add_users_individual_course,
                                            :create_users_individual_course, :like_course]
  before_action :check_user, only: [:like_course, :start_course]

  def start_course
    user_course = @user.users_courses.find_by_course_id(@course.id)
    if user_course
      user_course.is_started = true
      user_course.save
      started(user_course)
    else
      if @course.permission == "Public"
        can_start_course
      elsif @course.permission == "In organization"
        if @user.member_of_organization?(@course.author)
          can_start_course
        else
          flash[:success] =  "Only members of the organization is available to start course"
          redirect_to course_path
        end
      elsif @course.permission == "Individual"
        start_individual_course
      end
    end
  end

  def add_users_individual_course
    @users_not_in_list = User.all - @course.users
  end

  def create_users_individual_course
    @users = User.where(id: params.require(:course).permit(users:[])[:users])
    @course.users << @users
    @users.each { |user| UserMailer.invitation_to_course(user, @course).deliver_later }

    redirect_to course_pages_url(@course), notice: 'Users added.'
  end

  def like_course
    user_course = @user.users_courses.find_by_course_id(@course.id)
    if user_course
      user_course.is_liked == true ? user_course.is_liked = false : user_course.is_liked = true
    else
      user_course = @user.users_courses.build(course_id: @course.id, is_liked: true)
    end
    user_course.save
    redirect_to :back
  end

  private

  def check_user
    unless @user
      flash[:success] =  "To start the course You should sign up or log in"
      redirect_to new_user_session_path
    end
  end

  def start_individual_course
    user_course = @user.users_courses.find_by_course_id(@course.id)
    if user_course
      user_course.is_started = true
      started(user_course)
    else
      flash[:success] =  "You can not start course"
      redirect_to course_path
    end
  end

  def can_start_course
    user_course = UsersCourse.new(user_id: @user.id, course_id: @course.id, is_started: true)
    started(user_course)
  end

  def started(user_course)
    if user_course.save
      flash[:success] =  "Course is started"
    else
      flash[:success] =  "Course is not started"
    end
    redirect_to course_url(@course)
  end

  def set_course_and_user
    @course = Course.find(params[:course_id])
    @user = current_user
  end

end
