class VotesController < ApplicationController

  before_filter :find_votable 

  def index

    @votes = []

    if @votable.respond_to?('each')
      @votable.each do |vote|
        #audit comment
        @votes << vote
      end
    else
      @votes = @votable.votes
    end

    @votes

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @votable }
    end

  end

  def show
    #@comment = Comment.find(params[:id])

    @vote = @votable.votes.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @vote }
    end
  end

  def new

    #@comment = Comment.new
    @vote = @votable.votes.build
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @vote }
    end
  end

  def edit
    
  end

  def create

    @vote = @votable.votes.build(params[:vote])
    @vote.vote = 1
    @vote.user_id = current_user.id

    respond_to do |format|
      if @vote.save
        format.js {  }
        format.html { redirect_to [@votable, @vote] , notice: 'Vote was successfully created.' }
        #format.html { redirect_to news_comments_path , notice: 'Comment was successfully created.' }
        format.json { render json: @vote, status: :created, location: @vote }
      else
        format.html { render action: "new" }
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end

  end
  

  private

  def find_votable    

    #audit params
    if params[:comment_id]        
        @votable = Comment.find(params[:comment_id])

    elsif params[:news_id]        
        @votable = News.find(params[:news_id])

    elsif (params[:comment_id] && params[:id])
        @commentable = Comment.find(params[:comment_id])

    elsif (params[:news_id] && params[:id])
        @commentable = News.find(params[:news_id])

    else     
      @votable = Vote.all

    end
  end

end
