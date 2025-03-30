class DesiresController < ApplicationController

  def index
    @desires = Desire.prioritized
    @desire = Desire.new
  end

  def show
    @desire = Desire.find(params[:id])
  end

  def edit
    @desire = Desire.find(params[:id])
  end

  def create
    @desire = Desire.new(desire_params)

    respond_to do |format|
      if @desire.save
        format.html { redirect_to desires_url, notice: 'Intention was successfully created.' }
        format.json { render :show, status: :created, location: @desire }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@desire, partial: "desires/form", locals: { desire: @desire}) } #only need to provide stream on the fail state. otherwise turbo knows the RESTFUL flow (redirect to index.)
        format.html { render :new }
        format.json { render json: @desire.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @desire = Desire.find(params[:id])

    respond_to do |format|
      if @desire.update(desire_params)
        format.html { redirect_to desires_url, notice: 'Intention was successfully updated.' }
        format.json { render :show, status: :ok, location: @desire }
      else
        format.html { render :edit }
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@desire, partial: "desires/form", locals: { desire: @desire}) }
        format.json { render json: @desire.errors, status: :unprocessable_entity }
      end
    end
  end

  def prioritize
    @desire = Desire.find(params[:desire_id])
    @desire.increment_priority!
    @desires = Desire.prioritized


    respond_to do |format|
      format.html { redirect_to desires_url, notice: 'Intention was successfully prioritized.' }
      format.turbo_stream { render turbo_stream: turbo_stream.replace("desiresList", partial: "desires/list", locals: { desires: @desires}) }
      format.json { render :index, status: :ok }
    end
  end

  private

  def desire_params
    params.require(:desire).permit(:body, :priority)
  end
end
