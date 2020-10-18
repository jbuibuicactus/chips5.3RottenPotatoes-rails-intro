class Movie < ActiveRecord::Base
  
  def Movie.all_ratings
    return ['G', 'PG', 'PG-13', 'R']
    
    
  def Movie.with_ratings(ratings_selected)
    return Movie.where(ratings: ratings_selected)
    
end
