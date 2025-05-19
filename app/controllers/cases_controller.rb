class CasesController < ApplicationController
  before_action :set_case, only: %i[ show edit update destroy ]
  skip_before_action :validade_token, only: %i[ index ]
  
  # GET /cases or /cases.json
def index
  cases = Case.all.map do |c|
    c.as_json.merge({
      images: c.images.map { |img| url_for(img) },
      owner_email: c.user.email
    })
  end

  render json: cases
end

  # GET /cases/1 or /cases/1.json
  def show
    render json: @case.as_json.merge({
      images: @case.images.map { |img| url_for(img) },
      owner_email: @case.user.email
    })
  end

  # GET /cases/new
  def new
    @case = Case.new
  end

  # GET /cases/1/edit
  def edit
  end

  # POST /cases or /cases.json
  def create
    @user = User.find_by(
      id: case_params[:user_id], 
    )
   
    @case = Case.new(
      user: @user,
      description: case_params[:description], 
      institution_answer: case_params[:institution_answer], 
      images: case_params[:images]
    )

    respond_to do |format|
      if @case.save
        format.html { redirect_to case_url(@case), notice: "Case was successfully created." }
        format.json { render :show, status: :created, location: @case }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @case.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cases/1 or /cases/1.json
  def update
    respond_to do |format|
      if @case.update(case_params)
        format.html { redirect_to case_url(@case), notice: "Case was successfully updated." }
        format.json { render :show, status: :ok, location: @case }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @case.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cases/1 or /cases/1.json
  def destroy
    @case.destroy!

    respond_to do |format|
      format.html { redirect_to cases_url, notice: "Case was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_case
      @case = Case.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def case_params
      params.require(:case).permit(:user_id, :description, :institution_answer, images: [])

    end
end
