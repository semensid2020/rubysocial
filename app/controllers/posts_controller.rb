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
    @post.save

    # Редиректим на страницу показа поста.
    # Что касается адреса: тут идет конкатенация двух частей в один URL, а-ля  /posts/15
    redirect_to('/posts/' + @post.id.to_s)
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to '/posts/' + @post.id.to_s
  end

  private
  def post_params
    params.require(:post).permit(:title, :body, :topic_id)
  end
end
