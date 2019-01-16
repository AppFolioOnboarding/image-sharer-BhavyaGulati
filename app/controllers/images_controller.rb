class ImagesController < ApplicationController
  def new
    @image = Image.new
  end

  def create
    @image = Image.new(params.require(:image).permit(:url))
    if @image.save
      redirect_to image_path(@image)
    else
      flash[:danger] = 'Could not save an image'
      render 'new', status: :unprocessable_entity
    end
  end

  def show
    @image_url = Image.find(params[:id]).url
  rescue ActiveRecord::RecordNotFound
    flash[:danger] = 'Id not found'
    redirect_to action: :new
  end

  def index
    @images = Image.all.order('created_at DESC')
  end
end
