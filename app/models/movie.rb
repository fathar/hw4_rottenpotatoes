class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  
  class Movie::NoDirectorError < StandardError; end
  
  def self.similar_movies(id)
    movie = Movie.find id
    logger.info "movie=#{movie.inspect}"
    unless movie.director.blank?
      Movie.find_all_by_director movie.director
    else
      raise Movie::NoDirectorError, "'#{movie.title}' has no director info"
    end
  end
  
  def similar_movies
    if self.director
      Movie.find_all_by_director self.director
    else
      raise Movie::NoDirectorError, "#{self.title} has no director info"
    end
  end
end
