# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    # Your welcome page logic here
    render layout: false # Render without a layout
  end
end
