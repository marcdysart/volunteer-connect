class SearchController < ApplicationController
  def results
    case params['search_type']
    when 'people'
        person = Person.search(params[:search]).order("created_at DESC").first
        redirect_to person
    when 'location'
        location = Location.search(params[:search]).order("created_at DESC").first
        redirect_to location
    end
  end

end
