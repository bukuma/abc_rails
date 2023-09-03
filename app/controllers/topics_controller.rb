class TopicsController < ApplicationController
  before_action :authenticate_user!

  def index
    @title = params[:title]
    if @title.present?
      @topics = Topic.where('title LIKE ?', "%#{@title}%")
    else
      @topics = Topic.all
    end
    render :index
  end

  def new
    @topic = Topic.new
    render :new
  end
    
  def create
    @topic = Topic.new(topic_params)
    if params[:topic][:image]
      @topic.image.attach(params[:topic][:image])
    end
    
    if @topic.save
      redirect_to index_topic_path, notice: '登録しました'
    else
      render :new, status: :unprocessable_entity
    end
  end
    
  def edit
    @topic = Topic.find(params[:id])
    render :edit
  end
    
  def update
    @topic = Topic.find(params[:id])
    if params[:topic][:image]
      @topic.image.attach(params[:topic][:image])
    end
    if @topic.update(topic_params)
      redirect_to index_topic_path, notice: '更新しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy
      redirect_to index_topic_path, notice: '削除しました'
  end

  private
  def topic_params
    params.require(:topic).permit(:title, :body, :image)
  end 
end
