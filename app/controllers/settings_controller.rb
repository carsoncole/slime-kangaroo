class SettingsController < ApplicationController
  def about_me
  end

  def edit
    @setting = Setting.first_or_create
  end

  def update
    @setting = Setting.first
    if @setting.update(setting_params)
      redirect_to about_path, notice: 'Successfully updated.'
    else
      render :edit
    end
  end

  def setting_params
    params.require(:setting).permit(:about_me, :home_page_introduction)
  end
end
