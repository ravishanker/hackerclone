class CommentsController < ApplicationController


  def index
    @commentable = find_commentable
    #audit @commentable
    #@comments = @commentable.comments

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @commentable }
    end

  end

  def show
    @comment = Comment.find(params[:id])
    #@commentable = find_commentable
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @comment }
    end
  end

  def new

    @comment = Comment.new
    @commentable = find_commentable
    #     @comments = @commentable.comments.build(params[:comment])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @comments }
    end
  end

  def create

    @commentable = find_commentable
    #audit @commentable.user_id
    @comment = @commentable.comments.build(params[:comment])
    @comment.user_id = @commentable.user_id

    respond_to do |format|
      if @comment.save
        format.html { redirect_to news_comments_path , notice: 'Comment was successfully created.' }
        format.json { render json: @comment, status: :created, location: @comment }
      else
        format.html { render action: "new" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end

  end

  private

  def find_commentable
    # params.each do |name, value|
    #       if name =~ /(.+)_id$/
    #         return $1.classify.constantize.find(value)
    #       end
    #     end
    #     #raise ActiveRecord::NoRecord.new("Couldn\'t find it captain!")
    #     nil
        #audit params
        if params[:comment_id]
            return Comment.find(params[:comment_id])
        elsif params[:news_id]
            return News.find(params[:news_id])
        else
          return Comment.all
        end

  end


end
