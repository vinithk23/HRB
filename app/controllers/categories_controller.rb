class CategoriesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_category, only: %i[ show edit update destroy ]

    # GET /category or /category.json
    def index
      @category = Category.all
    end
  
    # GET /category/1 or /category/1.json
    def show
    end
  
    # GET /category/new
    def new
      @category = Category.new
    end
  
    # GET /category/1/edit
    def edit
    end
  
    # POST /category or /category.json
    def create
      @category = Category.new(category_params)
      respond_to do |format|
        if @category.save
          format.html { redirect_to category_url(@category), notice: "Category was successfully created." }
          format.json { render :show, status: :created, location: @category }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @category.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # PATCH/PUT /category/1 or /category/1.json
    def update
      respond_to do |format|

        if @category.update(category_params)
          format.html { redirect_to category_url(@category), notice: "Category was successfully updated." }
          format.json { render :show, status: :ok, location: @category }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @feature.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /category/1 or /category/1.json
    def destroy
      @category.destroy
  
      respond_to do |format|
        format.html { redirect_to categories_path, notice: "Category was successfully destroyed." }
        format.json { head :no_content }
      end
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_category
        @category = Category.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def category_params
        params.require(:category).permit(:name, :content, :amount, :image, feature_ids: [])
      end

end
