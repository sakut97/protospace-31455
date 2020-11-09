class PrototypesController < ApplicationController
  before_action :authenticate_user!, expext: [:index, :show]

  def index
   @prototypes = Prototype.includes(:user) #プロトタイプ情報の代入、N+1問題の解決
  end

  def new
    @prototype = Prototype.new  #引数の位置を変更
  end

  def create
      @prototype = Prototype.new(prototype_params) #createにも追加
      @prototype.save

      if @prototype.save
        redirect_to root_path
      else
        render :new
      end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments
  end

  def edit
    @prototype = Prototype.find(params[:id])
    unless current_user == @prototype.user
      redirect_to root_path 
    end
  end

  def update
    @prototype = Prototype.find(params[:id])
    

    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype)
    else
      render :edit
    end
  end

  def destroy
    @prototype = Prototype.find(params[:id])
    # if 
      @prototype.destroy
      redirect_to root_path
    # else
    #   redirect_to root_path
    # end
  end
  
  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id) #permitの中身不安
  end

end
