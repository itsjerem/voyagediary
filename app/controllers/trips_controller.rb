# Définition de la classe TripsController qui hérite de ApplicationController
class TripsController < ApplicationController
  # before_action est un filtre qui s'exécute avant certaines actions. Dans ce cas, il exécute la méthode set_trip avant les actions show, edit, update et destroy.
  before_action :set_trip, only: [:show, :edit, :update, :destroy]

  # Action pour afficher tous les voyages
  def index
    @trips = Trip.all
  end

  # Action pour afficher un voyage spécifique
  def show
       # La méthode set_trip a déjà été appelée grâce au before_action, donc @trip est déjà défini
  end

  # Action pour afficher le formulaire de création d'un nouveau voyage
  def new 
    @trip = Trip.new
    @users = User.all  # Récupère tous les utilisateurs pour les afficher dans le formulaire de création
  end 

  # Action pour afficher le formulaire d'édition d'un voyage existant
  def edit
  end

  # Action pour créer un nouveau voyage à partir des données du formulaire
  def create
    @trip = Trip.new(trip_params)  # Crée un nouveau voyage avec les paramètres du formulaire

    # Tente de sauvegarder le nouveau voyage
    if @trip.save
      # Si la sauvegarde réussit, redirige vers la page du voyage avec un message de succès
      redirect_to @trip, notice: 'Trip was successfully created.'
    else
      # Si la sauvegarde échoue, réaffiche le formulaire avec un statut d'erreur
      render :new, status: :unprocessable_entity
    end
  end
  
  # Action pour mettre à jour un voyage existant à partir des données du formulaire
  def update
    # Tente de mettre à jour le voyage
    if @trip.update(trip_params)
      # Si la mise à jour réussit, redirige vers la page du voyage avec un message de succès
      redirect_to trip_path(@trip), notice: 'Trip was successfully updated.'
    else
      # Si la mise à jour échoue, réaffiche le formulaire avec un statut d'erreur
      render :edit, status: :unprocessable_entity
    end
  end

  # Action pour supprimer un voyage existant
  def destroy
    @trip.destroy  # Supprime le voyage
    redirect_to trips_path, notice: 'Trip was successfully destroyed.'  # Redirige vers la page de tous les voyages
  end

  # Définition des méthodes privées
  private
  # Méthode pour sécuriser les paramètres du formulaire
  def trip_params   
    params.require(:trip).permit(:destination, :description, :start_date, :end_date, :user_id )   
  end 

  # Méthode pour récupérer le voyage correspondant à l'ID dans l'URL
  def set_trip
    @trip = Trip.find(params[:id])
  end
end