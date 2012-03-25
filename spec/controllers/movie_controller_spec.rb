require 'spec_helper'


describe MoviesController do
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
  
  describe 'find similar movies' do
    before :each do
      @fake_results = [mock('Movie'), mock('Movie')]
    end
    
    it 'should call the model method that finds similar movies' do
      Movie.should_receive(:similar_movies).with('1').and_return(@fake_results)
      post :similar_movies, {:id => 1}
    end
    
    describe 'after valid find' do
      before :each do
        Movie.stub(:similar_movies).and_return(@fake_results)
        post :similar_movies, {:id => 1}
      end
      
      it 'should render the similar movies template' do
        response.should render_template('similar_movies')
      end
    
      it 'should make the similar movies result available to the template' do
        assigns(:movies).should == @fake_results
      end
    end
    
    it 'should render home page for movies with no director info' do
      Movie.stub(:similar_movies).and_raise(Movie::NoDirectorError.new("No director error"))
      post :similar_movies, {:id => 1}
      flash[:notice].should == "No director error"
      response.should redirect_to('/')
    end
    
  end
end
