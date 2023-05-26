class PostsController < ApplicationController
  def index
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @topics = Topic.all()
  end

  def create
    @post = Post.new(params.require(:post).permit(:title, :body, :topic_id))
    @post.save

    # Редиректим на страницу показа поста.
    # Что касается адреса: тут идет конкатенация двух частей в один URL, а-ля  /posts/15
    redirect_to('/posts/' + @post.id.to_s)
  end
end
