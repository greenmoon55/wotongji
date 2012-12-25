# -*- encoding : utf-8 -*-
class Admin::CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def edit
    @category = Category.find(params[:id])
  end

  def create
    @category = Category.new(params[:category])
    if @category.save
      redirect_to admin_categories_path, notice: '创建成功'
    else
      render "new"
    end
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(params[:category])
      redirect_to admin_categories_path, notice: 'Category was successfully updated.' 
    else
      render "edit"
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to admin_categories_path, notice: '目录已删除'
  end
end
