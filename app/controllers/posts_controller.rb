class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]

  # include Pagy::Backend

  # GET /posts or /posts.json
  def index
    # @posts = current_user.posts
    @posts = Post.order(:created_at => :asc)
    @pagy, @posts = pagy_countless(@posts, items: 1)
  end

  # GET /posts/1 or /posts/1.json
  def show
    
  end

  def discover
    @posts = Post.all
  end
  
  def show
    @comment = @post.comments.build
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  def myposts
    @posts = current_user.posts

    if params[:username].present?
      @user = User.find_by(username: params[:username])
      if @user.nil?
        # Handle the case where the user is not found
        redirect_to root_path, alert: "User not found"
        return
      end
      @posts = @user.posts.order(created_at: :desc)
    else
      @user = current_user
      @posts = current_user.posts.order(created_at: :desc)
    end
    render "myposts"
  end
 

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :description, :keywords, :user_id, images: [])
    end
end
