class QuestionsController < ApplicationController
  before_action :set_question, only: %i[ show edit update destroy ]
  skip_before_action :set_question, only: %i[ questions_by_school schools ]
  skip_before_action :validade_token
  # GET /questions or /questions.json
  def index
    @questions = Question.all
  end

 def questions_by_school
    @questions = Question.where(school: params[:school])
    #Question.where(school: "porra")

    if @questions.exists?
      render json: @questions
    else
      render json: { error: "No questions found for school #{params[:school]}" }, status: :not_found
    end
  end

  def schools
    schools = Question.distinct.pluck(:school).compact
    render json: schools
  end


  # GET /questions/1 or /questions/1.json
  def show
  end

  # GET /questions/new
  def new
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions or /questions.json
  def create
    @question = Question.new(question_params)

    respond_to do |format|
      if @question.save
        format.html { redirect_to question_url(@question), notice: "Question was successfully created." }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1 or /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to question_url(@question), notice: "Question was successfully updated." }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1 or /questions/1.json
  def destroy
    @question.destroy!

    respond_to do |format|
      format.html { redirect_to questions_url, notice: "Question was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def question_params
      params.require(:question).permit(:school, :question)
    end
end
