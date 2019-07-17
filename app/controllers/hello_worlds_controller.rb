class HelloWorldsController < ApplicationController
  before_action :set_hello_world, only: [:show, :edit, :update, :destroy]

  # GET /hello_worlds
  # GET /hello_worlds.json
  def index
    respond_to do |format|
      format.html {
        @hello_worlds = HelloWorld.page(params[:page]).order(:priority)
      }
      format.csv {
        send_data(Babaloa.to_csv(HelloWorld.all.map(&:attributes), name: :hello_world), filename: "hello_worlds.csv", type: :csv)
      }
    end
  end

  # GET /hello_worlds/1
  # GET /hello_worlds/1.json
  def show; end

  # GET /hello_worlds/new
  def new
    @hello_world = HelloWorld.new
  end

  # GET /hello_worlds/1/edit
  def edit; end

  # POST /hello_worlds
  # POST /hello_worlds.json
  def create
    @hello_world = HelloWorld.new(hello_world_params)

    respond_to do |format|
      if @hello_world.save
        format.html { redirect_to @hello_world, notice: "Hello world was successfully created." }
        format.json { render :show, status: :created, location: @hello_world }
      else
        format.html { render :new }
        format.json { render json: @hello_world.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hello_worlds/1
  # PATCH/PUT /hello_worlds/1.json
  def update
    respond_to do |format|
      if @hello_world.update(hello_world_params)
        format.html { redirect_to @hello_world, notice: "Hello world was successfully updated." }
        format.json { render :show, status: :ok, location: @hello_world }
      else
        format.html { render :edit }
        format.json { render json: @hello_world.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hello_worlds/1
  # DELETE /hello_worlds/1.json
  def destroy
    @hello_world.destroy
    respond_to do |format|
      format.html { redirect_to hello_worlds_url, notice: "Hello world was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_hello_world
      @hello_world = HelloWorld.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def hello_world_params
      params.require(:hello_world).permit(:country, :hello, :priority, :image)
    end
end
