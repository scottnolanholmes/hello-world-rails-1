class StaticsController < ApplicationController
  def about; end

  def sample_form; end

  def ghibli
    @films = Api::GhibliApi.new.films
  end
end
