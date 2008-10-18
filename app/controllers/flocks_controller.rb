class FlocksController < ApplicationController
  resources_controller_for :flocks, :only => [:index, :new, :create]
end