class Admin::PromotionsController < Admin::AdminController
  before_action :set_admin_promotion, only: %i[ show edit update destroy ]

  # GET /admin/promotions or /admin/promotions.json
  def index
    @admin_promotions = Admin::Promotion.all
  end

  # GET /admin/promotions/1 or /admin/promotions/1.json
  def show
  end

  # GET /admin/promotions/new
  def new
    @admin_promotion = Admin::Promotion.new
  end

  # GET /admin/promotions/1/edit
  def edit
  end

  # POST /admin/promotions or /admin/promotions.json
  def create
    @admin_promotion = Admin::Promotion.new(admin_promotion_params)

    respond_to do |format|
      if @admin_promotion.save
        format.html { redirect_to @admin_promotion, notice: "Promotion was successfully created." }
        format.json { render :show, status: :created, location: @admin_promotion }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @admin_promotion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/promotions/1 or /admin/promotions/1.json
  def update
    respond_to do |format|
      if @admin_promotion.update(admin_promotion_params)
        format.html { redirect_to @admin_promotion, notice: "Promotion was successfully updated." }
        format.json { render :show, status: :ok, location: @admin_promotion }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @admin_promotion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/promotions/1 or /admin/promotions/1.json
  def destroy
    @admin_promotion.destroy
    respond_to do |format|
      format.html { redirect_to admin_promotions_url, notice: "Promotion was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_promotion
      @admin_promotion = Admin::Promotion.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_promotion_params
      params.require(:admin_promotion).permit(:code, :name, :has_free_shipping, :discount_percentage, :discount_dollars, :start, :end)
    end
end
