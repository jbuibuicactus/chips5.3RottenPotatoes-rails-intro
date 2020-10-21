class Movie < ActiveRecord::Base
  
  def Movie.all_ratings
    return ['G', 'PG', 'PG-13', 'R']
    
  end
    
    
  def Movie.with_ratings(ratings_selected)
    if ratings_selected.empty?
      return Movie.all
    end
    
    return Movie.where(rating: ratings_selected)
    
  end
  
  
  def Movie.selectedSort(sortstr)
    return Movie.order(sortstr)
  end
    
end
