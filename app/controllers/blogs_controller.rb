class BlogsController < ApplicationController
  before_action :authenticate_user
  before_action :set_blog, only: [:show, :edit, :update, :destroy]

  def index
    @blogs = Blog.all
  end

  def new
    @blog = Blog.new
  end

  # def confirm
  #   @blog = Blog.new(blog_params)
  #   render :new if @blog.invalid?
  # end

# 以下、編集にも確認画面を適用
  def confirm
    @blog = current_user.blogs.build(blog_params)
    @blog.id = params[:id]
    render :new if @blog.invalid?
  end

  def create
    @blog = current_user.blogs.build(blog_params)
    if params[:back]
      render :new
    else
      if @blog.save
        redirect_to blogs_path, notice: "ブログを作成しました！"
      else
        render :new
      end
    end
  end

  def show
    @favorite = current_user.favorites.find_by(blog_id: @blog.id)    
  end

  def edit
  end

  # def update
  #   if @blog.update(blog_params)
  #     redirect_to blogs_path, notice: "ブログを編集しました！"
  #   else
  #     render :edit
  #   end
  # end

  # 以下、編集にも確認画面を適用
  def update
    if params[:back]
      render :edit
    elsif @blog.update(blog_params)
      redirect_to blogs_path, notice: "ブログを編集しました！"
    else
      render :edit
    end
  end

  def destroy
    @blog.destroy
    redirect_to blogs_path, notice:"ブログを削除しました！"
  end

  private

  def blog_params
    params.require(:blog).permit(:title, :content)
  end

  def set_blog
    @blog = Blog.find(params[:id])
  end
end
