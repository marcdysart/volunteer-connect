class SearchController < ApplicationController
  def results
    if params[:second_search]
      person = Person.search(params[:second_search]).order("created_at DESC").first
      location = Location.search(params[:second_search]).order("created_at DESC").first
      @second_search = 'true'
      redirect_to :back
      return
    end

    case params['search_type']
      when 'period'
          redirect_to periods_path(params)
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
        @second_search = 'false'

    end



  end
end
