class Movie < ActiveRecord::Base
  
  def Movie.all_ratings
    return ['G', 'PG', 'PG-13', 'R']
    
  end
    
    
  def Movie.with_ratings(ratings_selected)
    return Movie.where(rating: ratings_selected)
    
  end
    
end
