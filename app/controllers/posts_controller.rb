class PostsController < ApplicationController
  def index
    @posts = Post.all()
  end

  def topic
    @topic = Topic.find_by(alias: params[:topic])
    @posts = @topic.posts
    render 'index'
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    # Топики забираем, чтобы отрендирить в select'е доступные для выбора категории постов (топики)
    @topics = Topic.all()
    @post = Post.find(params[:id])
  end

  def new
    @topics = Topic.all()
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      # Редиректим на страницу показа поста.
      # Что касается адреса: тут идет конкатенация двух частей в один URL, а-ля  /posts/15
      redirect_to('/posts/' + @post.id.to_s)
    else
      # Нам нужно опять показать форму, поэтому снова забираем топики,
      # т.к. нам нужно снова отрендерить поле select, чтобы отобразить форму со всеми топиками.
      @topics = Topic.all()
      render 'new'
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to('/posts/' + @post.id.to_s)
    else
      @topics = Topic.all()
      render 'edit'
    end
  end

  private
  def post_params
    params[:post][:topic_id] = params[:post][:topic]
    params.require(:post).permit(:title, :body, :topic_id)
  end
end
