class CampVehiclesController < ApplicationController
  include Campable
  before_action :locked, only: [:create, :edit, :update, :destroy]
end