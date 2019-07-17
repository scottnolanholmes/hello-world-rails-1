class StaticsController < ApplicationController
  def about; end

  def sample_form; end

  def ghibli
    @films = Api::GhibliApi.new.films
    respond_to do |format|
      format.html
      format.csv {
        send_data(Babaloa.to_csv(@films, name: :ghibli), filename: "ghibli_films.csv", type: :csv)
      }
    end
  end
end
