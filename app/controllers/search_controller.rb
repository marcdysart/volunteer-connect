class SearchController < ApplicationController
  def results
    case params['search_type']
    when 'person'
        person = Person.search(params[:search]).order("created_at DESC").first
        redirect_to person
    when 'location'
        location = Location.search(params[:search]).order("created_at DESC").first
        redirect_to location
    else
      person = Person.search(params[:search]).order("created_at DESC").first
      location = Location.search(params[:search]).order("created_at DESC").first
      if person.nil?
        if location.nil?
          redirect_to :back
        else
          redirect_to location
        end
      else
        redirect_to person
      end

    end
  end

end
