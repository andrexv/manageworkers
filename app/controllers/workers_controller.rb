class WorkersController < ApplicationController
  before_filter :authenticate_worker!
  
  def index
    redirect_to worker_path(current_worker.id)
  end

  def show
    @worker = Worker.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @worker }
    end
  end

  def edit
    @worker = Worker.find(params[:id])
  end

  def create
    @worker = Worker.new(params[:worker])

    respond_to do |format|
      if @worker.save
        format.html { redirect_to @worker, notice: 'Worker was successfully created.' }
        format.json { render json: @worker, status: :created, location: @worker }
      else
        format.html { render action: "new" }
        format.json { render json: @worker.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @worker = Worker.find(params[:id])

    respond_to do |format|
      if @worker.update_attributes(params[:worker])
        format.html { redirect_to @worker, notice: 'Worker was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @worker.errors, status: :unprocessable_entity }
      end
    end
  end
end
