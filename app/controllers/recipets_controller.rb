class RecipetsController < ApplicationController
  def index 
    @recipets = Recipet.all
  end

  def new
    @recipet = Recipet.new
  end

  def show
    @recipet = Recipet.find(params[:id])
  end

  def edit
    @recipet = Recipet.find(params[:id])
  end

  def update
    @recipet = Recipet.find(params[:id])
    if @recipet.update(recipet_params)
      redirect_to @recipet, notice: 'recipet was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @recipet = Recipet.find(params[:id])
    @recipet.destroy
    redirect_to recipets_path, notice: 'recipet was successfully destroyed.'
  end

 private
  def recipet_params
    params.require(:recipet).permit(:user_id, :purchased_at)
  end
end
