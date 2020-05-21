class SearchEnginesController < ApplicationController
  def index
    @output = JSON.parse(params[:body]) if params[:body]
  end

  def create
    file = params[:search_engine][:file]

    if file
      file_data = file.read
      output = SearchEngine.new.execute(file_data)

      redirect_to search_engines_path(body: output.to_json)
    else
      render 'index'
    end
  end
end
