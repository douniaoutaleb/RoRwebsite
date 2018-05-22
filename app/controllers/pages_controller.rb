class PagesController < ApplicationController

  def index
    @cours = Cour.paginate(:page => params[:page], :per_page => 4)
  end

  def prof
    @cours_prof = Cour.where(professeur: current_user.id)
  end

  def theme_crypto
    @cours = Cour.where(theme: 'Cryptographie')
  end

  def theme_ia
    @cours = Cour.where(theme: 'Intelligence artificielle')
  end

  def theme_securite
    @cours = Cour.where(theme: "Sécurité des systèmes d'informations" )
  end

  def theme_analyse
    @cours = Cour.where(theme: 'Analyse et statistique des données')
  end

end
