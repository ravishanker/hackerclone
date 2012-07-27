class CommentsController < ApplicationController

  before_filter :find_commentable 

  def index

    @comments = []

    if @commentable.respond_to?('each')
      @commentable.each do |comment|
        #audit comment
        @comments << comment
      end
    else
      @comments = @commentable.comments
    end

    @comments

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @commentable }
    end

  end

  def show
    #@comment = Comment.find(params[:id])

    @comment = @commentable.comments.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @comment }
    end
  end

  def new

    #@comment = Comment.new
    @comment = @commentable.comments.build
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @comments }
    end
  end

  def edit
    
  end

  def create

    @comment = @commentable.comments.build(params[:comment])
    @comment.user_id = current_user.id

    respond_to do |format|
      if @comment.save
        format.html { redirect_to [@commentable, @comment] , notice: 'Comment was successfully created.' }
        #format.html { redirect_to news_comments_path , notice: 'Comment was successfully created.' }
        format.json { render json: @comment, status: :created, location: @comment }
      else
        format.html { render action: "new" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end

  end
  

  private

  def find_commentable    

    #audit params
    if params[:comment_id]        
        @commentable = Comment.find(params[:comment_id])

    elsif params[:news_id]        
        @commentable = News.find(params[:news_id])

    elsif (params[:comment_id] && params[:id])
        @commentable = Comment.find(params[:comment_id])

    elsif (params[:news_id] && params[:id])
        @commentable = News.find(params[:news_id])

    else     
      @commentable = Comment.all

    end
  end


end
