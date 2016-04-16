class UsersController < ApplicationController

  before_action :find_user, only: [:profile, :courses, :organizations]

  def profile
  end

  def courses
    @courses = @user.courses.where(author: @user).paginate(page: params[:page], per_page: 4)
  end

  def organizations
    @organizations = @user.organizations
  end

  def show
    @user = current_user
    respond_to do |format|
      format.pdf { send_file TestPdfForm.new(@user).export, type: 'application/pdf' }
    end
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

end
