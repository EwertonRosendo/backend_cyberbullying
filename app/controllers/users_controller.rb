include Rails.application.routes.url_helpers

class UsersController < ApplicationController
  include SessionsHelper
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :validade_token, only: %i[index new]
  #skip_before_action :validade_token, only: %i[create]

  # GET /users or /users.json
  def index
    @users = User.all
  
    respond_to do |format|
      format.html
      format.json {
        render json: @users.map { |user|
          user.attributes.merge({
            kind: user.kind, # ensure kind comes as string
            photo_url: user.photo.attached? ? url_for(user.photo) : nil
          })
        }
      }
    end
  end

  # GET /users/1 or /users/1.json
  def show
    respond_to do |format|
      format.html { render :show }  # Renders app/views/users/show.html.erb
      format.json {
        render json: @user.as_json.merge({
          photo_url: @user.photo.attached? ? url_for(@user.photo) : nil
        })
      }
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to user_url(@user), notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy!

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def users_by_school
  school = params[:school]
  @users = User.includes(:cases, school_answers: :question).where(school: school)

  render json: @users.map { |user|
    {
      id: user.id,
      email: user.email,
      kind: user.kind,
      photo_url: user.photo.attached? ? url_for(user.photo) : nil,
      cases: user.cases.map do |c|
        {
          id: c.id,
          description: c.description,
          institution_answer: c.institution_answer,
          created_at: c.created_at,
          images: c.images.map { |image| url_for(image) }
        }
      end,
      school_answers: user.school_answers.map do |answer|
        {
          id: answer.id,
          answer: answer.answer,
          created_at: answer.created_at,
          question: {
            id: answer.question.id,
            question: answer.question.question,
            school: answer.question.school
          }
        }
      end
    }
  }
end




  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :password, :password_digest, :photo, :kind, :school)
    end
end
