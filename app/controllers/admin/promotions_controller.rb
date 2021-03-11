class Admin::PromotionsController < Admin::AdminController
  before_action :set_admin_promotion, only: %i[ show edit update destroy ]

  def index
    @admin_promotions = Admin::Promotion.all
  end

  def show
  end

  def new
    @admin_promotion = Admin::Promotion.new
  end

  def edit
  end

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

  def destroy
    @admin_promotion.destroy
    respond_to do |format|
      format.html { redirect_to admin_promotions_url, notice: "Promotion was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_admin_promotion
      @admin_promotion = Admin::Promotion.find(params[:id])
    end

    def admin_promotion_params
      params.require(:admin_promotion).permit(:code, :name, :has_free_shipping, :discount_percentage, :discount_dollars, :start, :end)
    end
end
