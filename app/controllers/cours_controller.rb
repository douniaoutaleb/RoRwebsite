class CoursController < ApplicationController
  before_action :set_cour, only: [:show, :edit, :update, :destroy]

  # GET /cours
  # GET /cours.json
  def index
    @cours = Cour.paginate(:page => params[:page], :per_page => 6)
  end

  # GET /cours/1
  # GET /cours/1.json
  def show
  end

  # GET /cours/new
  def new
    @prof = Array.new()
    @cour = Cour.new
    @pro = User.find(current_user.id)
    @prof << @pro.nom+" "+@pro.prenom
  end

  def register_fail
    if logged_in?
      a = Abonnement.find_by(id_user: current_user.id,id_cours: params[:id_cour])
      if a == nil
        Abonnement.create(id_user: current_user.id, id_cours: params[:id_cour])
        flash[:success] = 'Vous êtes maintenant inscrit à ce cours.'
        redirect_to abonnements_url
      else
        flash[:success] = 'Vous êtes déjà inscrit à ce cours.'
        redirect_to abonnements_url
      end
    else
      flash[:danger] = 'Should log in first'
      redirect_to cours_url
    end
  end

  # GET /cours/1/edit
  def edit
    @prof = Array.new()
    @pro = User.find(current_user.id)
    @prof << @pro.nom+" "+@pro.prenom
  end

  # POST /cours
  # POST /cours.json
  def create
    @cour = Cour.new(cour_params)
    @pro = User.where(user_type: "P")
    @pro.each{ |a|
      @prof << a.nom+" "+a.prenom
    }
    respond_to do |format|
      if @cour.save
        format.html { redirect_to @cour, notice: 'Cour was successfully created.' }
        format.json { render :show, status: :created, location: @cour }
      else
        format.html { render :new }
        format.json { render json: @cour.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cours/1
  # PATCH/PUT /cours/1.json
  def update
    respond_to do |format|
      if @cour.update(cour_params)
        format.html { redirect_to @cour, notice: 'Cour was successfully updated.' }
        format.json { render :show, status: :ok, location: @cour }
      else
        format.html { render :edit }
        format.json { render json: @cour.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cours/1
  # DELETE /cours/1.json
  def destroy
    id = @cour.id
    @cour.destroy
    Abonnement.where(:id_cours => id).destroy_all
    respond_to do |format|
      format.html { redirect_to cours_url, notice: 'Cour was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cour
      @cour = Cour.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cour_params
      params.require(:cour).permit(:nom, :institution, :theme, :langue, :professeur, :description)
    end
end
