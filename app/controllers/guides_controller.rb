class GuidesController < ApplicationController
  before_action :handle_authorization

  # GET /guides
  def index
  end

  # GET /guides/build
  def build
  end

  # GET /guides/bunny_bar
  def bunny_bar
  end

  # GET /guides/covid
  def covid
  end

  # GET /guides/deposit
  def deposit
  end

  # GET /guides/disclaimer
  def disclaimer
  end

  # GET /guides/dues
  def dues
  end

  # GET /guides/events
  def events
    @david = ::User.find_by_id(Settings.user.david)
    @mirabelle = ::User.find_by_id(Settings.user.mirabelle)
    @lindsay = ::User.find_by_id(Settings.user.lindsay)
  end

  # GET /guides/history
  def history
  end

  # GET /guides/ice
  def ice
  end

  # GET /guides/jobs
  def jobs
  end

  # GET /guides/kitchen
  def kitchen
  end

  # GET /guides/lag_bolts
  def lag_bolts
  end

  # GET /guides/learn
  def learn
  end

  # GET /guides/map
  def map
  end

  # GET /guides/mayor_of_the_day
  def mayor_of_the_day
  end

  # GET /guides/outside_services
  def outside_services
  end

  # GET /guides/parking
  def parking
  end

  # GET /guides/power
  def power
  end

  # GET /guides/projects
  def projects
  end

  # GET /guides/sauna
  def sauna
  end

  # GET /guides/shipping_container
  def shipping_container
  end

  # GET /guides/sound
  def sound
  end

  # GET /guides/strike
  def strike
  end

  # GET /guides/tickets
  def tickets
  end

  # GET /guides/tools
  def tools
  end

  # GET /guides/trash
  def trash
  end

  # GET /guides/work_access_pass
  def work_access_pass
    @camp_work_access_passes = ::CampWorkAccessPass.all.order_by_date
  end

  # GET /guides/yearbook
  def yearbook
  end

  private

  def handle_authorization
    authorize(:guide)
  end
end
