class ImagesController < ApplicationController
  def new
    @image = Image.new
  end

  def create
    @image = Image.new(params.require(:image).permit(:url, :tag_list))
    if @image.save
      redirect_to image_path(@image)
    else
      flash[:danger] = 'Could not save an image'
      render 'new', status: :unprocessable_entity
    end
  end

  def show
    @image = Image.find(params[:id])
    @image_url = Image.find(params[:id]).url
  rescue ActiveRecord::RecordNotFound
    flash[:danger] = 'Id not found'
    redirect_to action: :new
  end

  def index
    if params[:tag]
      flash.now[:danger] = 'Tags have no images associated' if Image.tagged_with(params[:tag]).empty?
      @images = Image.tagged_with(params[:tag]).order('created_at Desc')
    else
      @images = Image.all.order('created_at Desc')
    end
  end
end
