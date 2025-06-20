class RecipetsController < ApplicationController
  def index 
    
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
      render :edi
    end
  end

  def destroy
    @recipett = Recipet.find(params[:id])
    @recipett.destroy
    redirect_to recipets_path, notice: 'recipett was successfully destroyed.'
  end
end
