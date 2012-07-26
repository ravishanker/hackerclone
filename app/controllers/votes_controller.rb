class VotesController < ApplicationController

  def index
    @votable = find_votable
    @votes = @votable.votes

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @votes }
    end

  end

  def new
    @votes = Vote.new

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @votes }
    end

  end

  def create
    @votable = find_votable
    @vote = @votable.votes.build(params[:vote])

    if @vote.save
      format.html { redirect_to @vote, notice: 'Vote was successfully created.' }
      format.json { render json: @vote, status: :created, location: @vote }
    else
      format.html { render action: "new" }
      format.json { render json: @vote.errors, status: :unprocessable_entity }
    end

  end

  def find_votable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end

end
