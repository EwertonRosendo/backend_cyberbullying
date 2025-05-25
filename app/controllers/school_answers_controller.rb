class SchoolAnswersController < ApplicationController
  before_action :set_school_answer, only: %i[ show edit update destroy ]
  skip_before_action :validade_token
  before_action :user_already_answered?, only: [:create]

  # GET /school_answers or /school_answers.json
  def index
    @school_answers = SchoolAnswer.all
  end

  # GET /school_answers/1 or /school_answers/1.json
  def show
  end

  # GET /school_answers/new
  def new
    @school_answer = SchoolAnswer.new
  end

  # GET /school_answers/1/edit
  def edit
  end

  # POST /school_answers or /school_answers.json
def create
  # Expecting an array of answers in params[:school_answers]
  if params[:school_answers].is_a?(Array)
    created_answers = []

    params[:school_answers].each do |answer_params|
      school_answer = SchoolAnswer.new(answer_params.permit(:question_id, :user_id, :answer))
      if school_answer.save
        created_answers << school_answer
      else
        render json: { error: "Failed to save answer", details: school_answer.errors.full_messages }, status: :unprocessable_entity
        return
      end
    end

    render json: created_answers, status: :created
  else
    render json: { error: "Expected an array of answers" }, status: :bad_request
  end
end

  # PATCH/PUT /school_answers/1 or /school_answers/1.json
  def update
    respond_to do |format|
      if @school_answer.update(school_answer_params)
        format.html { redirect_to school_answer_url(@school_answer), notice: "School answer was successfully updated." }
        format.json { render :show, status: :ok, location: @school_answer }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @school_answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /school_answers/1 or /school_answers/1.json
  def destroy
    @school_answer.destroy!

    respond_to do |format|
      format.html { redirect_to school_answers_url, notice: "School answer was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_school_answer
      @school_answer = SchoolAnswer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def school_answer_params
      params.require(:school_answer).permit(:question_id, :user_id, :answer)
    end

    def user_already_answered?
      @answer = params[:school_answers].first if params[:school_answers].is_a?(Array)
      exist = SchoolAnswer.exists?(user_id: @answer["user_id"])
      if exist
        render json: { error: "User has already answered" }, status: :unprocessable_entity
      end
    end
end
