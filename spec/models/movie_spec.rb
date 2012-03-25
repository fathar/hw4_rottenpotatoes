require 'spec_helper'

describe Movie do
  MORE_MOVIES = [
    {:title => 'Star Wars', :rating => 'PG', :director => 'George Lucas', :release_date => '1977-05-25'},
    {:title => 'Blade Runner', :rating => 'PG', :director => 'Ridley Scott', :release_date => '1982-06-25'},
    {:title => 'Alien', :rating => 'R', :release_date => '1979-05-25'},
    {:title => 'THX-1138', :rating => 'R', :director => 'George Lucas', :release_date => '1971-03-11'}
  ]

  before :each do
    MORE_MOVIES.each do |movie|
      Movie.create!(movie)
    end
  end
  
  context 'class method find similar movies' do
    it 'should find similar movies' do
      movie= Movie.find_by_director('George Lucas')
      Movie.similar_movies(movie.id).count.should == 2
    end
    
    it 'should raise a NoDirectorError for movies with no director' do
      movie = Movie.create(:title => "foo bar")
      lambda{Movie.similar_movies(movie.id)}.should raise_error(Movie::NoDirectorError)
    end
  end
  
  context 'find similar movies' do
    it 'should find similar movies' do
      movie= Movie.find_by_director('George Lucas')
      movie.similar_movies.count.should == 2
    end
    
    it 'should raise a NoDirectorError for movies with no director' do
      movie = Movie.create(:title => "foo bar")
      lambda{movie.similar_movies}.should raise_error(Movie::NoDirectorError)
    end
  end
end