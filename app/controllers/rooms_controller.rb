class RoomsController < ApplicationController
    before_action :authenticate_user!
    before_action :checkBookedStatus, only: %i[update]
    before_action :set_room, only: %i[ show edit update destroy ]

    # GET /room or /room.json
    def index
      # @rooms = Room.includes(:category).paginate(page: params[:page], per_page: 10)
      @rooms = Room.includes(:category).paginate(page: params[:page], per_page: 10)
    end
  
    # GET /room/1 or /room/1.json
    def show
    end
  
    # GET /room/new
    def new
      @room = Room.new
    end
  
    # GET /room/1/edit
    def edit
    end
  
    # POST /room or /room.json
    def create
      @room = Room.new(room_params)
      respond_to do |format|
        if @room.save
          format.html { redirect_to room_path(@room), notice: "room was successfully created." }
          format.json { render :show, status: :created, location: @room }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @room.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # PATCH/PUT /room/1 or /room/1.json
    def update
      respond_to do |format|

        if @room.update(room_params)
          format.html { redirect_to room_path(@room), notice: "Room was successfully updated." }
          format.json { render :show, status: :ok, location: @room }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @feature.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /room/1 or /room/1.json
    def destroy
      @room.destroy
  
      respond_to do |format|
        format.html { redirect_to rooms_path, notice: "Room was successfully destroyed." }
        format.json { head :no_content }
      end
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_room
        @room = Room.includes(:category).find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def room_params
        params.require(:room).permit(:room_no, :category_id, :status)
      end

end
